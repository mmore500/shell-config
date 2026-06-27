-- Solarized (workbench.colorTheme: "Solarized Light" / "Solarized (dark)")
return {
  {
    "f-person/auto-dark-mode.nvim",
    priority = 1000,
    dependencies = { "maxmx03/solarized.nvim" },
    config = function()
      local function apply(mode)
        vim.o.background = mode
        require("solarized").setup({ transparent = { enabled = false } })
        vim.cmd.colorscheme("solarized")
      end
      require("auto-dark-mode").setup({
        update_interval = 1000,
        set_dark_mode = function() apply("dark") end,
        set_light_mode = function() apply("light") end,
      })
      -- Re-apply after all plugins load so bufferline (and others that hook
      -- ColorScheme) pick up highlights that were set before they initialized.
      vim.api.nvim_create_autocmd("VimEnter", {
        once = true,
        callback = function()
          vim.schedule(function()
            if vim.g.colors_name then
              vim.cmd("colorscheme " .. vim.g.colors_name)
            end
          end)
        end,
      })
    end,
  },
}
