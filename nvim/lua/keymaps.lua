local map = vim.keymap.set
local o = { noremap = true, silent = true }

-- ── File navigation ──────────────────────────────────────────────────────────
-- Ctrl+Up/Down → top/bottom of file (VSCode: cursorTop / cursorBottom)
map({ "n", "v" }, "<C-Up>",   "gg",          o)
map({ "n", "v" }, "<C-Down>", "G",           o)
map("i",          "<C-Up>",   "<C-o>gg",     o)
map("i",          "<C-Down>", "<C-o>G",      o)

-- Ctrl+Left/Right → line start/end (VSCode: cursorLineStart / cursorEnd)
map({ "n", "v" }, "<C-Left>",  "^",     o)
map({ "n", "v" }, "<C-Right>", "$",     o)
map("i",          "<C-Left>",  "<Home>", o)
map("i",          "<C-Right>", "<End>",  o)

-- Alt+Left/Right → word left/right (VSCode: cursorWordStartLeft / cursorWordEndRight)
map({ "n", "v" }, "<M-Left>",  "b",       o)
map({ "n", "v" }, "<M-Right>", "w",       o)
map("i",          "<M-Left>",  "<C-o>b",  o)
map("i",          "<M-Right>", "<C-o>w",  o)

-- Alt+Up/Down → 10 lines (VSCode: cursorMove by 10)
map({ "n", "v" }, "<M-Up>",   "10k",      o)
map({ "n", "v" }, "<M-Down>", "10j",      o)
map("i",          "<M-Up>",   "<C-o>10k", o)
map("i",          "<M-Down>", "<C-o>10j", o)

-- Alt+Shift+Up/Down → select 10 lines
map("n", "<M-S-Up>",   "v10k", o)
map("n", "<M-S-Down>", "v10j", o)
map("v", "<M-S-Up>",   "10k",  o)
map("v", "<M-S-Down>", "10j",  o)

-- ── Editing ───────────────────────────────────────────────────────────────────
-- Ctrl+Shift+X → delete line (VSCode: editor.action.deleteLines)
map("n", "<C-S-x>", "dd",          o)
map("i", "<C-S-x>", "<C-o>dd",     o)

-- Ctrl+Shift+D → duplicate line down (VSCode: editor.action.copyLinesDownAction)
map("n", "<C-S-d>", "yyp",         o)
map("i", "<C-S-d>", "<C-o>yy<C-o>p", o)

-- Move lines up/down (VSCode: cmd+pageup/pagedown → editor.action.moveLinesUp/Down)
map("n", "<M-S-k>", "<cmd>move .-2<cr>==",          o)
map("n", "<M-S-j>", "<cmd>move .+1<cr>==",          o)
map("v", "<M-S-k>", ":move '<-2<cr>gv=gv",          o)
map("v", "<M-S-j>", ":move '>+1<cr>gv=gv",          o)

-- Ctrl+S → save
map({ "n", "i", "v" }, "<C-s>", "<cmd>w<cr>", o)

-- Ctrl+Z / Ctrl+Shift+Z → undo/redo
map({ "n", "i" }, "<C-z>",   "<cmd>undo<cr>", o)
map({ "n", "i" }, "<C-S-z>", "<cmd>redo<cr>", o)

-- Indent / outdent in visual (Ctrl+]/[ like VSCode)
-- Note: <C-]> kept as tag-jump in normal mode; visual is unambiguous
map("v", "<C-]>", ">gv", o)
map("v", "<C-[>", "<gv", o)

-- ── Buffer / tab navigation ───────────────────────────────────────────────────
-- ]b / [b → next/prev buffer (like Ctrl+Shift+] / Ctrl+Shift+[)
map("n", "]b", "<cmd>bnext<cr>",     o)
map("n", "[b", "<cmd>bprev<cr>",     o)
-- Also wire up the actual key combos; note <C-[> = Escape in many terminals
-- so we use Shift variants which are safer
map("n", "<C-S-]>", "<cmd>bnext<cr>", o)
map("n", "<C-S-[>", "<cmd>bprev<cr>", o)

-- ── Git hunk navigation (VSCode: alt+g down/up → next/prev change) ────────────
-- These are wired in the gitsigns config (on_attach) so they only activate
-- when gitsigns is loaded. Defined here for reference:
--   ]c / [c → next/prev hunk  (set in plugins/ui.lua gitsigns on_attach)
--   <M-u>   → revert hunk     (set in plugins/ui.lua gitsigns on_attach)

-- ── Diagnostics ───────────────────────────────────────────────────────────────
map("n", "<leader>e", vim.diagnostic.open_float,          o)
map("n", "[d",        vim.diagnostic.goto_prev,           o)
map("n", "]d",        vim.diagnostic.goto_next,           o)
map("n", "<leader>q", vim.diagnostic.setloclist,          o)

-- ── Formatting ────────────────────────────────────────────────────────────────
map({ "n", "v" }, "<leader>f", function()
  require("conform").format({ async = true, lsp_fallback = true })
end, o)

-- ── Spell corrections (VSCode: ctrl+shift+; → cSpell.suggestSpellingCorrections)
map("n", "<C-S-;>", "z=",       o)
map("i", "<C-S-;>", "<C-o>z=",  o)

-- ── Sidebar / file tree (VSCode: ctrl+\ → toggleSidebarVisibility) ────────────
map("n", "<C-\\>", "<cmd>Neotree toggle<cr>", o)

-- ── Fuzzy finder (VSCode: ctrl+p → quick open) ───────────────────────────────
map("n", "<C-p>",     "<cmd>Telescope find_files<cr>",  o)
map("n", "<leader>fg", "<cmd>Telescope live_grep<cr>",  o)
map("n", "<leader>fb", "<cmd>Telescope buffers<cr>",    o)
map("n", "<leader>fh", "<cmd>Telescope help_tags<cr>",  o)

-- ── Window navigation ─────────────────────────────────────────────────────────
map("n", "<C-h>", "<C-w>h", o)
map("n", "<C-j>", "<C-w>j", o)
map("n", "<C-k>", "<C-w>k", o)
map("n", "<C-l>", "<C-w>l", o)

-- ── Misc ──────────────────────────────────────────────────────────────────────
-- Clear search highlight (like Escape clearing highlights)
map("n", "<Esc>", "<cmd>nohlsearch<cr>", o)

-- Jump to matching bracket (VSCode: ctrl+m → editor.action.jumpToBracket)
-- Note: <C-m> = Enter in terminals, so use <leader>m instead
map("n", "<leader>m", "%", o)
