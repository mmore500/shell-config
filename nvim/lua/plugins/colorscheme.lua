-- Solarized Light (workbench.colorTheme: "Solarized Light")
return {
  {
    "maxmx03/solarized.nvim",
    priority = 1000,
    opts = {
      transparent = false,
      styles = {
        comments = {},
        keywords = {},
        functions = {},
      },
    },
    config = function(_, opts)
      vim.o.background = "light"
      require("solarized").setup(opts)
      vim.cmd.colorscheme("solarized")
    end,
  },
}
