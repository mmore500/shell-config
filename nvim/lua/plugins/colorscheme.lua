-- Solarized Light (workbench.colorTheme: "Solarized Light")
return {
  {
    "maxmx03/solarized.nvim",
    priority = 1000,
    config = function()
      vim.o.background = "light"
      require("solarized").setup({
        transparent = { enabled = false },
      })
      vim.cmd.colorscheme("solarized")
    end,
  },
}
