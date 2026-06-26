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
