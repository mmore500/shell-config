return {
  -- Mason: installs LSP server binaries
  {
    "williamboman/mason.nvim",
    cmd   = "Mason",
    build = ":MasonUpdate",
    config = function()
      require("mason").setup()
    end,
  },

  -- nvim-lspconfig: ships default server configs (cmd, filetypes, root_markers)
  -- into neovim's runtimepath. We do NOT call require('lspconfig').server.setup()
  -- anymore — that framework is deprecated in nvim 0.11.
  { "neovim/nvim-lspconfig" },

  -- mason-lspconfig: installs servers via mason and enables them via vim.lsp.enable()
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      "williamboman/mason.nvim",
      "neovim/nvim-lspconfig",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      -- Global: cmp completion capabilities for every LSP server
      vim.lsp.config("*", {
        capabilities = require("cmp_nvim_lsp").default_capabilities(),
      })

      -- Per-server overrides (python.defaultInterpreterPath: /usr/bin/python)
      vim.lsp.config("pyright", {
        settings = {
          python = { pythonPath = "/usr/bin/python" },
        },
      })

      -- Buffer-local keymaps on LSP attach (replaces the on_attach callback pattern)
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspKeymaps", { clear = true }),
        callback = function(ev)
          local b = { noremap = true, silent = true, buffer = ev.buf }
          -- Go to definition / references / implementation (F12 / Shift+F12 in VSCode)
          vim.keymap.set("n", "gd",         vim.lsp.buf.definition,     b)
          vim.keymap.set("n", "gD",         vim.lsp.buf.declaration,    b)
          vim.keymap.set("n", "gr",         vim.lsp.buf.references,     b)
          vim.keymap.set("n", "gi",         vim.lsp.buf.implementation, b)
          -- Hover docs (mouse hover in VSCode)
          vim.keymap.set("n", "K",          vim.lsp.buf.hover,          b)
          -- Rename symbol (F2 in VSCode)
          vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename,         b)
          -- Code actions (Ctrl+. in VSCode)
          vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action,    b)
          vim.keymap.set("v", "<leader>ca", vim.lsp.buf.code_action,    b)
        end,
      })

      -- Diagnostic display
      vim.diagnostic.config({
        virtual_text     = true,
        signs            = true,
        underline        = true,
        update_in_insert = false,
        severity_sort    = true,
        float = { border = "rounded", source = true },
      })

      require("mason-lspconfig").setup({
        ensure_installed = {
          "pyright",       -- Python
          "clangd",        -- C/C++
          "rust_analyzer", -- Rust
          "zls",           -- Zig
          "yamlls",        -- YAML
        },
        -- automatic_enable calls vim.lsp.enable() for each installed server
        automatic_enable = true,
      })
    end,
  },
}
