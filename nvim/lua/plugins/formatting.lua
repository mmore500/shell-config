return {
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd   = { "ConformInfo" },
    config = function()
      require("conform").setup({
        formatters_by_ft = {
          python = { "black" },                    -- ms-python.black-formatter
          c      = { "clang_format" },             -- xaver.clang-format
          cpp    = { "clang_format" },
          sh     = { "shfmt" },                    -- timonwong.shellcheck (format side)
          bash   = { "shfmt" },
          lua    = { "stylua" },
        },

        -- Format on save only for Python (editor.formatOnSave in [python] block)
        format_on_save = function(bufnr)
          local ft = vim.bo[bufnr].filetype
          if ft == "python" then
            return { timeout_ms = 5000, lsp_fallback = false }
          end
        end,

        formatters = {
          -- black-formatter.args: ["--line-length=80"]
          black = {
            prepend_args = { "--line-length", "80" },
          },
          clang_format = {
            -- respects .clang-format in the project; no global override needed
          },
          shfmt = {
            prepend_args = { "-i", "4" },  -- 4-space indentation
          },
        },
      })
    end,
  },

  -- Shell linting (timonwong.shellcheck)
  {
    "mfussenegger/nvim-lint",
    event = { "BufWritePost", "BufReadPost" },
    config = function()
      require("lint").linters_by_ft = {
        sh   = { "shellcheck" },
        bash = { "shellcheck" },
      }
      vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost" }, {
        callback = function()
          require("lint").try_lint()
        end,
      })
    end,
  },
}
