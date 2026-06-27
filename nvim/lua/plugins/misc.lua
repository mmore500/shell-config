return {
  -- Commenting (VSCode built-in Ctrl+/)
  {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup()
      -- gcc → toggle line comment, gbc → toggle block comment (normal mode)
      -- gc / gb → toggle comment (visual mode)
    end,
  },

  -- Which-key: shows available keybindings (discoverability)
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
      require("which-key").setup({
        delay = 500,
      })
      -- Register leader-key groups
      require("which-key").add({
        { "<leader>f",  group = "format / find" },
        { "<leader>g",  group = "git" },
        { "<leader>r",  group = "refactor / rename" },
        { "<leader>c",  group = "code action" },
        { "<leader>s",  group = "spell" },
      })
    end,
  },

  -- Flash: cursor-jump navigation (davidlgoldberg.jumpy2 equivalent)
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    keys = {
      { "s",      mode = { "n", "x", "o" }, function() require("flash").jump() end,       desc = "Flash jump" },
      { "S",      mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash treesitter" },
      { "<S-CR>", mode = { "n", "x", "o" }, function() require("flash").jump() end,       desc = "Flash jump" },
    },
  },

  -- Docstring generation (njpwerner.autodocstring → autoDocstring.docstringFormat: "numpy")
  {
    "danymat/neogen",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("neogen").setup({
        enabled = true,
        languages = {
          python = { template = { annotation_convention = "numpydoc" } },
          c      = { template = { annotation_convention = "doxygen" } },
          cpp    = { template = { annotation_convention = "doxygen" } },
        },
      })
      vim.keymap.set("n", "<leader>ng", require("neogen").generate,
        { noremap = true, silent = true, desc = "Generate docstring" })
    end,
  },

  -- Session restore: auto-save/restore per working directory
  {
    "rmagatti/auto-session",
    lazy = false,
    config = function()
      require("auto-session").setup({
        auto_save_enabled = true,
        auto_restore_enabled = true,
        -- Don't restore sessions for home/root/tmp (too broad)
        auto_session_suppress_dirs = { "~/", "/", "/tmp" },
        pre_save_cmds = { "Neotree close" },
      })
    end,
  },

  -- Multicursor: Alt+D → select word / add next occurrence (VSCode Ctrl+D)
  {
    "mg979/vim-visual-multi",
    branch = "master",
    init = function()
      vim.g.VM_maps = {
        ["Find Under"]         = "<M-d>",
        ["Find Subword Under"] = "<M-d>",
      }
      vim.g.VM_default_mappings = 0
    end,
  },

  -- Rainbow CSV (mechatroner.rainbow-csv — same plugin, vim-compatible)
  {
    "mechatroner/rainbow_csv",
    ft = { "csv", "tsv", "csv_semicolon", "csv_whitespace" },
  },

  -- LaTeX (james-yu.latex-workshop → vimtex is the standard neovim equivalent)
  {
    "lervag/vimtex",
    ft = "tex",
    init = function()
      vim.g.vimtex_view_method    = "zathura"
      vim.g.vimtex_compiler_method = "latexmk"
      -- latex-workshop.latex.autoBuild.run: "never"
      vim.g.vimtex_compiler_latexmk = { continuous = 0 }
    end,
  },

  -- Markdown preview (shd101wyy.markdown-preview-enhanced)
  {
    "iamcco/markdown-preview.nvim",
    cmd   = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft    = { "markdown" },
    build = "cd app && npx --yes yarn install",
    config = function()
      vim.keymap.set("n", "<leader>mp", "<cmd>MarkdownPreviewToggle<cr>",
        { noremap = true, silent = true, desc = "Toggle markdown preview" })
    end,
  },

  -- Markdown linting (davidanson.vscode-markdownlint) via nvim-lint
  -- shellcheck is already in formatting.lua; add markdownlint here
  -- (requires: npm install -g markdownlint-cli)
  -- If markdownlint-cli is not installed, this silently does nothing.
}
