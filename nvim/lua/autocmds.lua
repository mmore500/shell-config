local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Trim trailing whitespace on save (trailing-spaces.trimOnSave)
augroup("TrimWhitespace", { clear = true })
autocmd("BufWritePre", {
  group = "TrimWhitespace",
  pattern = "*",
  callback = function()
    local pos = vim.api.nvim_win_get_cursor(0)
    vim.cmd([[silent! %s/\s\+$//e]])
    -- clamp row in case lines were removed
    local line_count = vim.api.nvim_buf_line_count(0)
    pos[1] = math.min(pos[1], line_count)
    vim.api.nvim_win_set_cursor(0, pos)
  end,
})

-- Trim extra final newlines (files.trimFinalNewlines)
augroup("TrimFinalNewlines", { clear = true })
autocmd("BufWritePre", {
  group = "TrimFinalNewlines",
  pattern = "*",
  callback = function()
    local pos = vim.api.nvim_win_get_cursor(0)
    vim.cmd([[silent! %s/\(\n\)\+\%$//e]])
    local line_count = vim.api.nvim_buf_line_count(0)
    pos[1] = math.min(pos[1], line_count)
    vim.api.nvim_win_set_cursor(0, pos)
  end,
})

-- Enable spell check for prose (cSpell.documentTypes: markdown, latex, plaintext)
augroup("SpellCheck", { clear = true })
autocmd("FileType", {
  group = "SpellCheck",
  pattern = { "markdown", "tex", "text", "gitcommit" },
  callback = function()
    vim.opt_local.spell = true
  end,
})

-- No 80-col ruler for prose/bib files
augroup("NoColorColumn", { clear = true })
autocmd("FileType", {
  group = "NoColorColumn",
  pattern = { "markdown", "tex", "bib" },
  callback = function()
    vim.opt_local.colorcolumn = ""
  end,
})

-- Python-specific settings (editor.tabSize: 4, editor.insertSpaces: true)
augroup("PythonSettings", { clear = true })
autocmd("FileType", {
  group = "PythonSettings",
  pattern = "python",
  callback = function()
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
    vim.opt_local.expandtab = true
    vim.opt_local.textwidth = 80
  end,
})

-- Highlight yanked text briefly
augroup("YankHighlight", { clear = true })
autocmd("TextYankPost", {
  group = "YankHighlight",
  callback = function()
    vim.highlight.on_yank({ timeout = 200 })
  end,
})

-- After session restore, wipe any empty [No Name] buffers that linger after
-- all plugins finish loading. "User VeryLazy" is Lazy.nvim's own signal that
-- every deferred plugin has initialised — no timer needed.
augroup("WipeNoName", { clear = true })
autocmd("User", {
  group    = "WipeNoName",
  pattern  = "VeryLazy",
  once     = true,
  callback = function()
    local bufs = vim.fn.getbufinfo({ buflisted = 1 })
    if #bufs <= 1 then return end   -- keep the sole buffer (fresh start, no session)
    for _, b in ipairs(bufs) do
      if vim.api.nvim_buf_get_name(b.bufnr) == "" then
        local lines = vim.api.nvim_buf_get_lines(b.bufnr, 0, -1, false)
        if #lines == 0 or (#lines == 1 and lines[1] == "") then
          for _, win in ipairs(vim.api.nvim_list_wins()) do
            if vim.api.nvim_win_get_buf(win) == b.bufnr then
              for _, other in ipairs(bufs) do
                if other.bufnr ~= b.bufnr
                    and vim.api.nvim_buf_get_name(other.bufnr) ~= "" then
                  pcall(vim.api.nvim_win_set_buf, win, other.bufnr)
                  break
                end
              end
            end
          end
          pcall(vim.cmd, "bwipeout! " .. b.bufnr)
        end
      end
    end
  end,
})
