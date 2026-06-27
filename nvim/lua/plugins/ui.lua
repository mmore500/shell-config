return {
  -- Icons (requires BlexMono Nerd Font — already installed)
  { "nvim-tree/nvim-web-devicons" },

  -- Buffer tab bar across the top (like VSCode's tab strip)
  {
    "akinsho/bufferline.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("bufferline").setup({
        options = {
          mode            = "buffers",
          separator_style = "slant",
          show_close_icon = false,
          show_buffer_close_icons = false,
          diagnostics     = "nvim_lsp",
          offsets = {
            {
              filetype   = "neo-tree",
              text       = "Files",
              highlight  = "Directory",
              separator  = true,
            },
          },
        },
      })
      -- Wire ]b / [b through bufferline for consistent cycling
      vim.keymap.set("n", "]b", "<cmd>BufferLineCycleNext<cr>", { noremap = true, silent = true })
      vim.keymap.set("n", "[b", "<cmd>BufferLineCyclePrev<cr>", { noremap = true, silent = true })
      -- Close current buffer
      vim.keymap.set("n", "<leader>bd", "<cmd>bdelete<cr>", { noremap = true, silent = true })
    end,
  },

  -- File tree: sidebar toggle (VSCode: ctrl+\ → toggleSidebarVisibility)
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch       = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    config = function()
      require("neo-tree").setup({
        close_if_last_window = true,
        window = { width = 30 },
        default_component_configs = {
          container = {
            width = "fit_content",
            -- fit_content makes remaining_width always 0, so fade fires on every item; disable it
            enable_character_fade = false,
          },
        },
        filesystem = {
          filtered_items = {
            visible      = true,   -- show hidden files (like VSCode explorer.confirmDelete)
            hide_dotfiles = false,
          },
          follow_current_file = { enabled = true },
          commands = {
            scroll_tree_right = function(_state)
              local v = vim.fn.winsaveview()
              v.leftcol = v.leftcol + 6
              vim.fn.winrestview(v)
            end,
            scroll_tree_left = function(_state)
              local v = vim.fn.winsaveview()
              v.leftcol = math.max(0, v.leftcol - 6)
              vim.fn.winrestview(v)
            end,
            show_context_menu = function(state)
              local mousepos = vim.fn.getmousepos()
              if mousepos.line > 0 then
                vim.api.nvim_win_set_cursor(state.winid, { mousepos.line, 0 })
              end
              local node = state.tree:get_node()
              if not node or node.type == "message" then return end
              local is_dir = node.type == "directory"

              local Menu  = require("nui.menu")
              local event = require("nui.utils.autocmd").event

              local action_names = { "Open", "Duplicate", "Rename", "Delete" }
              if is_dir then
                table.insert(action_names, "New File Here")
                table.insert(action_names, "New Folder Here")
              end
              table.insert(action_names, "Copy Path")

              local lines = {}
              for i, name in ipairs(action_names) do
                table.insert(lines, Menu.item(i .. "  " .. name))
              end

              local function execute(name)
                local fc = require("neo-tree.sources.filesystem.commands")
                if name == "Open" then
                  fc.open(state)
                elseif name == "Duplicate" then
                  local parent = vim.fn.fnamemodify(node.path, ":h")
                  local _, fname = require("neo-tree.utils").split_path(node.path)
                  require("neo-tree.sources.filesystem.lib.fs_actions").copy_node(
                    node.path, parent .. "/copy_of_" .. fname,
                    function() require("neo-tree.sources.manager").refresh("filesystem") end,
                    parent
                  )
                elseif name == "Rename" then
                  fc.rename(state)
                elseif name == "Delete" then
                  fc.delete(state)
                elseif name == "New File Here" then
                  fc.add(state)
                elseif name == "New Folder Here" then
                  fc.add_directory(state)
                elseif name == "Copy Path" then
                  vim.fn.setreg("+", node.path)
                  vim.notify("Copied: " .. node.path)
                end
              end

              local menu = Menu({
                relative = "cursor",
                position = { row = 1, col = 0 },
                size     = { width = 22 },
                border   = {
                  style = "rounded",
                  text  = { top = " " .. node.name .. " ", top_align = "left" },
                },
              }, {
                lines  = lines,
                keymap = {
                  focus_next = { "j", "<Down>", "<Tab>" },
                  focus_prev = { "k", "<Up>", "<S-Tab>" },
                  close      = { "<Esc>", "<C-c>", "q" },
                  submit     = { "<CR>", "<Space>" },
                },
                on_submit = function(item)
                  execute(item.text:match("^%d+ +(.+)$") or item.text)
                end,
              })

              menu:mount()

              -- Number key shortcuts: press the item's number to fire instantly
              for i, name in ipairs(action_names) do
                menu:map("n", tostring(i), function()
                  menu:unmount()
                  execute(name)
                end, { noremap = true, nowait = true })
              end

              -- Mouse click: fire immediately on the clicked item
              local function handle_click()
                local pos  = vim.fn.getmousepos()
                local line = pos.line
                if line >= 1 and line <= #action_names then
                  menu:unmount()
                  execute(action_names[line])
                end
              end
              menu:map("n", "<LeftMouse>",   handle_click, { noremap = true, nowait = true })
              menu:map("n", "<2-LeftMouse>", handle_click, { noremap = true, nowait = true })

              -- Close and restore focus when the menu window loses focus
              menu:on(event.BufLeave, function()
                vim.schedule(function()
                  pcall(menu.unmount, menu)
                  if vim.api.nvim_win_is_valid(state.winid) then
                    vim.api.nvim_set_current_win(state.winid)
                  end
                end)
              end)
            end,
          },
          window = {
            mappings = {
              ["<ScrollWheelRight>"] = "scroll_tree_right",
              ["<ScrollWheelLeft>"]  = "scroll_tree_left",
              ["<RightMouse>"]       = "show_context_menu",
            },
          },
        },
      })

      -- Neo-tree forces `nolist` on every BufEnter (setup/init.lua:173).
      -- Re-enable it after neo-tree's handler so the › extends character
      -- shows at the viewport edge for lines that continue off-screen.
      -- Use only extends/precedes — not space/tab dots — in the tree window.
      vim.api.nvim_create_autocmd("BufEnter", {
        callback = function()
          if vim.bo.filetype == "neo-tree" then
            vim.schedule(function()
              if vim.bo.filetype == "neo-tree" then
                vim.opt_local.list = true
                vim.opt_local.listchars = { extends = "›", precedes = "‹" }
              end
            end)
          end
        end,
      })
    end,
  },

  -- Status line (bottom bar like VSCode)
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({
        options = {
          theme = "auto",
          globalstatus = true,
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { "branch", "diff", "diagnostics" },
          lualine_c = { { "filename", path = 1 } },
          lualine_x = { "encoding", "fileformat", "filetype" },
          lualine_y = { "progress" },
          lualine_z = { "location" },
        },
      })
    end,
  },

  -- Git signs + blame (waderyan.gitblame + inline diff indicators)
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup({
        -- git.blame.editorDecoration.enabled: false → inline blame off by default
        current_line_blame = false,
        signs = {
          add          = { text = "+" },
          change       = { text = "~" },
          delete       = { text = "_" },
          topdelete    = { text = "‾" },
          changedelete = { text = "~" },
        },
        on_attach = function(bufnr)
          local gs = package.loaded.gitsigns
          local b  = { noremap = true, silent = true, buffer = bufnr }

          -- Alt+G Down/Up → next/prev hunk (VSCode: alt+g down / alt+g up)
          vim.keymap.set("n", "<M-g><Down>", gs.next_hunk, b)
          vim.keymap.set("n", "<M-g><Up>",   gs.prev_hunk, b)
          -- Also wire ]c / [c (conventional vim convention)
          vim.keymap.set("n", "]c", gs.next_hunk, b)
          vim.keymap.set("n", "[c", gs.prev_hunk, b)

          -- Alt+U → revert hunk (VSCode: alt+u → git.revertSelectedRanges)
          vim.keymap.set({ "n", "v" }, "<M-u>", gs.reset_hunk, b)

          -- Toggle blame annotation
          vim.keymap.set("n", "<leader>gb", gs.toggle_current_line_blame, b)
          -- Preview hunk diff
          vim.keymap.set("n", "<leader>gd", gs.preview_hunk, b)
        end,
      })
    end,
  },

  -- Indent guides (visual aid for indentation levels)
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    config = function()
      require("ibl").setup({
        indent = { char = "│" },
        scope  = { enabled = false },
      })
    end,
  },
}
