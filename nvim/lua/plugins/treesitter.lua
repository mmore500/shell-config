return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "python", "c", "cpp", "rust", "zig", "lua", "vim", "vimdoc",
          "markdown", "markdown_inline", "bash", "cmake", "json", "jsonc",
          "yaml", "toml", "latex", "csv",
        },
        auto_install = true,
        highlight = { enable = true },
        indent   = { enable = true },
      })
    end,
  },
}
