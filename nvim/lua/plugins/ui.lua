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
        filesystem = {
          filtered_items = {
            visible      = true,   -- show hidden files (like VSCode explorer.confirmDelete)
            hide_dotfiles = false,
          },
          follow_current_file = { enabled = true },
        },
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
