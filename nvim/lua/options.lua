local opt = vim.opt

-- Line numbers
opt.number = true

-- Tabs / indentation (Python: 4 spaces; general default)
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.smartindent = true

-- Soft wrap: visual wrapping only, no hard newlines inserted
opt.wrap = true
opt.linebreak = true      -- break at word boundaries, not mid-word
opt.textwidth = 0         -- disable hard wrapping
opt.colorcolumn = "80"    -- keep the 80-col ruler as a visual guide

-- Show all whitespace (editor.renderWhitespace: "all")
opt.list = true
opt.listchars = {
  space    = "·",
  tab      = "»·",
  trail    = "•",
  extends  = "›",
  precedes = "‹",
  nbsp     = "⣿",
}

-- Search
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true

-- Files
opt.fixeol = true   -- ensure final newline (files.insertFinalNewline)
opt.swapfile = false
opt.backup = false
opt.undofile = true
opt.undodir = vim.fn.stdpath("data") .. "/undo"

-- Mouse
opt.mouse = "a"

-- UI
opt.termguicolors = true
opt.scrolloff = 8
opt.sidescrolloff = 8
opt.signcolumn = "yes"
opt.splitright = true
opt.splitbelow = true
opt.laststatus = 2

-- Clipboard (use system clipboard)
opt.clipboard = "unnamedplus"

-- Completion menu
opt.completeopt = { "menu", "menuone", "noselect" }

-- Remove 't' from formatoptions so typing never auto-inserts hard line breaks
vim.api.nvim_create_autocmd("BufEnter", {
  callback = function() vim.opt_local.formatoptions:remove("t") end,
})

-- Spelling (enabled per-filetype in autocmds)
opt.spelllang = "en_us"

-- No auto-closing of brackets/quotes (editor.autoClosingBrackets/Quotes: "never")
-- achieved by not loading an autopairs plugin

-- Ensure undo directory exists
vim.fn.mkdir(vim.fn.stdpath("data") .. "/undo", "p")
