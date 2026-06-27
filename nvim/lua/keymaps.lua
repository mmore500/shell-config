local map = vim.keymap.set
local o = { noremap = true, silent = true }

-- ── File navigation ──────────────────────────────────────────────────────────
-- Up/Down arrows → move by visual (soft-wrapped) line; j/k keep physical-line behavior
map({ "n", "v" }, "<Up>",   "gk",       o)
map({ "n", "v" }, "<Down>", "gj",       o)
map("i",          "<Up>",   "<C-o>gk",  o)
map("i",          "<Down>", "<C-o>gj",  o)

-- Ctrl+Up/Down → top/bottom of file (VSCode: cursorTop / cursorBottom)
map({ "n", "v" }, "<C-Up>",   "gg",      o)
map({ "n", "v" }, "<C-Down>", "G",       o)
map("i",          "<C-Up>",   "<C-o>gg", o)
map("i",          "<C-Down>", "<C-o>G",  o)

-- Ctrl+Left/Right → line start/end (VSCode: cursorLineStart / cursorEnd)
map({ "n", "v" }, "<C-Left>",  "^",      o)
map({ "n", "v" }, "<C-Right>", "$",      o)
map("i",          "<C-Left>",  "<Home>", o)
map("i",          "<C-Right>", "<End>",  o)

-- Shift+Arrow → select by character (VSCode: cursorLeftSelect / cursorRightSelect etc.)
-- Up/Down use gk/gj to follow soft-wrapped lines; H/J/K/L navigate by physical line in visual.
map("n", "<S-Left>",  "vh",  o)
map("n", "<S-Right>", "vl",  o)
map("n", "<S-Up>",    "vgk", o)
map("n", "<S-Down>",  "vgj", o)
map("v", "<S-Left>",  "h",   o)
map("v", "<S-Right>", "l",   o)
map("v", "<S-Up>",    "gk",  o)
map("v", "<S-Down>",  "gj",  o)
map("v", "H",         "h",   o)
map("v", "J",         "j",   o)
map("v", "K",         "k",   o)
map("v", "L",         "l",   o)
map("i", "<S-Left>",  "<Esc>vh",   o)
map("i", "<S-Right>", "<Esc>vl",   o)
map("i", "<S-Up>",    "<Esc>vgk",  o)
map("i", "<S-Down>",  "<Esc>vgj",  o)

-- Ctrl+Shift+Up/Down → select to top/bottom (VSCode: cursorTopSelect / cursorBottomSelect)
map("n", "<C-S-Up>",   "vgg",     o)
map("n", "<C-S-Down>", "vG",      o)
map("v", "<C-S-Up>",   "gg",      o)
map("v", "<C-S-Down>", "G",       o)
map("i", "<C-S-Up>",   "<Esc>lvgg", o)
map("i", "<C-S-Down>", "<Esc>lvG",  o)

-- Ctrl+Shift+Left/Right → select to line start/end (VSCode: cursorLineStartSelect / cursorEndSelect)
map("n", "<C-S-Left>",  "v^",      o)
map("n", "<C-S-Right>", "v$",      o)
map("v", "<C-S-Left>",  "^",       o)
map("v", "<C-S-Right>", "$",       o)
map("i", "<C-S-Left>",  "<Esc>v^",   o)
map("i", "<C-S-Right>", "<Esc>lv$",  o)
-- Raw-sequence fallbacks: xterm-kitty terminfo omits kLFT6/kRIT6/kUP6/kDN6,
-- so \E[1;6D/C/A/B arrive unmapped and the <C-S-*> keymaps above never fire.
vim.keymap.set('n', '\27[1;6D', 'v^',        o)  -- Ctrl+Shift+Left
vim.keymap.set('v', '\27[1;6D', '^',         o)
vim.keymap.set('i', '\27[1;6D', '<Esc>v^',   o)
vim.keymap.set('n', '\27[1;6C', 'v$',        o)  -- Ctrl+Shift+Right
vim.keymap.set('v', '\27[1;6C', '$',         o)
vim.keymap.set('i', '\27[1;6C', '<Esc>lv$',  o)
vim.keymap.set('n', '\27[1;6A', 'vgg',       o)  -- Ctrl+Shift+Up
vim.keymap.set('v', '\27[1;6A', 'gg',        o)
vim.keymap.set('i', '\27[1;6A', '<Esc>lvgg', o)
vim.keymap.set('n', '\27[1;6B', 'vG',        o)  -- Ctrl+Shift+Down
vim.keymap.set('v', '\27[1;6B', 'G',         o)
vim.keymap.set('i', '\27[1;6B', '<Esc>lvG',  o)

-- Alt+Left/Right → word left/right (VSCode: cursorWordStartLeft / cursorWordEndRight)
map({ "n", "v" }, "<M-Left>",  "b",      o)
map({ "n", "v" }, "<M-Right>", "w",      o)
map("i",          "<M-Left>",  "<C-o>b", o)
map("i",          "<M-Right>", "<C-o>w", o)

-- Alt+Shift+Left/Right → select word (VSCode: cursorWordStartLeftSelect / cursorWordEndRightSelect)
map("n", "<M-S-Left>",  "vb", o)
map("n", "<M-S-Right>", "ve", o)
map("v", "<M-S-Left>",  "b",  o)
map("v", "<M-S-Right>", "e",  o)

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

-- Alt+T then Arrow → move between panes
map("n", "<M-t><Left>",  "<C-w>h", o)
map("n", "<M-t><Right>", "<C-w>l", o)
map("n", "<M-t><Up>",    "<C-w>k", o)
map("n", "<M-t><Down>",  "<C-w>j", o)

-- ── Editing ───────────────────────────────────────────────────────────────────
-- Ctrl+X → cut (VSCode: cut); overrides vim's decrement-number
-- clipboard=unnamedplus so the default register is already the system clipboard
map("n", "<C-x>", "dd",      o)   -- cut line
map("v", "<C-x>", "d",       o)   -- cut selection
map("i", "<C-x>", "<C-o>dd", o)   -- cut line in insert mode

-- Ctrl+V → paste (VSCode: paste); overrides vim's visual-block mode
-- In visual mode, delete to black hole first so clipboard isn't clobbered
map("n", "<C-v>", "p",      o)
map("v", "<C-v>", '"_dp',   o)
map("i", "<C-v>", '<C-r>"', o)

-- Ctrl+Shift+X → delete line (VSCode: editor.action.deleteLines)
map("n", "<C-S-x>", "dd",             o)
map("i", "<C-S-x>", "<C-o>dd",        o)

-- Ctrl+Shift+D → word select / add next occurrence (alias for Alt+D / vim-visual-multi)
-- feedkeys through <M-d> so vm's own map fires; avoids Plug autoload timing issues.
map({ "n", "v" }, "<C-S-d>", function()
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<M-d>", true, false, true), "m", false)
end, o)

-- Move lines up/down (VSCode: cmd+pageup/pagedown → editor.action.moveLinesUp/Down)
map("n", "<M-S-k>", "<cmd>move .-2<cr>==", o)
map("n", "<M-S-j>", "<cmd>move .+1<cr>==", o)
map("v", "<M-S-k>", ":move '<-2<cr>gv=gv", o)
map("v", "<M-S-j>", ":move '>+1<cr>gv=gv", o)

-- Shell-style line editing (emacs keys)
map({ "n", "v" }, "<C-a>", "^",         o)  -- beginning of line
map("i",          "<C-a>", "<Home>",    o)
map({ "n", "v" }, "<C-e>", "$",         o)  -- end of line
map("i",          "<C-e>", "<End>",     o)
map("n",          "<C-d>", '"_x',       o)  -- delete char under cursor (no yank)
map("i",          "<C-d>", "<Delete>",  o)  -- delete char forward

-- Ctrl+S → save; Ctrl+Shift+S → save as (VSCode: workbench.action.files.saveAs)
map({ "n", "i", "v" }, "<C-s>",   "<cmd>w<cr>", o)
map({ "n", "i", "v" }, "<C-S-s>", function()
  vim.ui.input({ prompt = "Save as: ", default = vim.fn.expand("%") }, function(name)
    if name and name ~= "" then vim.cmd("saveas " .. vim.fn.fnameescape(name)) end
  end)
end, o)

-- Ctrl+Z / Ctrl+Shift+Z → undo/redo
map({ "n", "i" }, "<C-z>",   "<cmd>undo<cr>", o)
map({ "n", "i" }, "<C-S-z>", "<cmd>redo<cr>", o)

-- Ctrl+W → close buffer without closing windows/neovim (VSCode: closeActiveEditor)
-- bdelete alone closes all windows showing the buffer; this re-homes them first.
map("n", "<C-w>", function()
  local cur = vim.api.nvim_get_current_buf()
  local bufs = vim.fn.getbufinfo({ buflisted = 1 })
  local next_buf
  for _, b in ipairs(bufs) do
    if b.bufnr ~= cur then next_buf = b.bufnr; break end
  end
  if not next_buf then
    -- Last buffer: only land on a blank "No Name" if the buffer being
    -- closed is itself empty; otherwise :quit closes the window cleanly.
    local lines = vim.api.nvim_buf_get_lines(cur, 0, -1, false)
    local is_empty = #lines <= 1 and (lines[1] == nil or lines[1] == "")
    if is_empty then
      vim.api.nvim_win_set_buf(0, vim.api.nvim_create_buf(true, false))
      pcall(vim.cmd, "bdelete " .. cur)
    else
      pcall(vim.cmd, "quit")
    end
    return
  end
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    if vim.api.nvim_win_get_buf(win) == cur then
      vim.api.nvim_win_set_buf(win, next_buf)
    end
  end
  pcall(vim.cmd, "bdelete " .. cur)
end, o)


-- Backspace → delete selection without clobbering clipboard (VSCode: backspace in visual)
map("v", "<BS>", '"_d', o)

-- Indent / outdent in visual (VSCode: ctrl+]/[)
map("v", "<C-]>", ">gv", o)
map("v", "<C-[>", "<gv", o)

-- Alt+T → transpose two characters (VSCode: alt+t → extension.transpose)
map("n", "<M-t>", "xp", o)

-- ── Buffer / tab navigation ───────────────────────────────────────────────────
-- VSCode: ctrl+] → nextEditor, ctrl+shift+[ → previousEditor
-- Note: <C-[> = Escape in terminals and cannot be remapped.
-- <C-]> overrides tag-jump; LSP gd covers that instead.
map("n", "<C-]>",      "<cmd>BufferLineCycleNext<cr>", o)
map("n", "<C-}>",      "<cmd>BufferLineCycleNext<cr>", o)
map("n", "<C-S-]>",   "<cmd>BufferLineCycleNext<cr>", o)
map("n", "<C-S-[>",   "<cmd>BufferLineCyclePrev<cr>", o)
map("n", "<C-{>",      "<cmd>BufferLineCyclePrev<cr>", o)
map("n", "]b",         "<cmd>BufferLineCycleNext<cr>", o)
map("n", "[b",         "<cmd>BufferLineCyclePrev<cr>", o)
map("n", "<C-PageDown>", "<cmd>BufferLineCycleNext<cr>", o)
map("n", "<C-PageUp>",   "<cmd>BufferLineCyclePrev<cr>", o)

-- ── Splits (VSCode: ctrl+k direction → moveEditorToGroup) ─────────────────────
-- <C-k> is window-up, so use <leader>k as the split prefix
map("n", "<leader>kl", "<cmd>vsplit<cr><C-w>l", o)  -- new split right
map("n", "<leader>kh", "<cmd>vsplit<cr>",        o)  -- new split left (stay)
map("n", "<leader>kj", "<cmd>split<cr><C-w>j",  o)  -- new split below
map("n", "<leader>kk", "<cmd>split<cr>",         o)  -- new split above (stay)

-- ── Fold navigation (VSCode: ctrl+shift+. / ctrl+shift+,) ─────────────────────
map("n", "<C-S-.>", "zj", o)  -- next fold
map("n", "<C-S-,>", "zk", o)  -- prev fold

-- ── Git hunk navigation (VSCode: alt+g down/up → next/prev change) ────────────
--   ]c / [c  → next/prev hunk  (set in plugins/ui.lua gitsigns on_attach)
--   <M-u>    → revert hunk     (set in plugins/ui.lua gitsigns on_attach)

-- ── Diagnostics ───────────────────────────────────────────────────────────────
map("n", "<leader>e", vim.diagnostic.open_float, o)
map("n", "[d",        vim.diagnostic.goto_prev,  o)
map("n", "]d",        vim.diagnostic.goto_next,  o)
map("n", "<leader>q", vim.diagnostic.setloclist, o)

-- ── Formatting ────────────────────────────────────────────────────────────────
map({ "n", "v" }, "<leader>f", function()
  require("conform").format({ async = true, lsp_fallback = true })
end, o)

-- ── Spell corrections (VSCode: ctrl+shift+; → cSpell.suggestSpellingCorrections)
map("n", "<C-S-;>", "z=",      o)
map("i", "<C-S-;>", "<C-o>z=", o)

-- Ctrl+N → new empty buffer (VSCode: workbench.action.files.newUntitledFile)
-- Only in normal mode; insert-mode <C-n> is reserved for completion.
map("n", "<C-n>", "<cmd>enew<cr>", o)

-- ── Sidebar (VSCode: ctrl+\ → toggle, alt+\ → focus/unfocus) ─────────────────
map("n", "<C-\\>", "<cmd>Neotree toggle<cr>", o)
map("n", "<M-\\>", "<cmd>Neotree focus<cr>",  o)

-- ── Fuzzy finder (VSCode: ctrl+p → quick open, ctrl+f → find in file, ctrl+shift+f → find in project) ─
map("n", "<C-p>", function()                                            -- quick open
  local in_git = vim.fn.system("git rev-parse --is-inside-work-tree 2>/dev/null"):match("true")
  local opts = in_git
    and { hidden = true, find_command = { "git", "ls-files", "--cached", "--others", "--exclude-standard" } }
    or  { hidden = true }
  require("telescope.builtin").find_files(opts)
end, o)
map("n", "<C-f>",   "<cmd>Telescope current_buffer_fuzzy_find<cr>", o)  -- find in file (VSCode ctrl+f)
map("n", "<C-S-f>", "<cmd>Telescope live_grep<cr>",                 o)  -- find in project
map("n", "<leader>fg", "<cmd>Telescope live_grep<cr>",              o)  -- find in project (universal)
map("n", "<leader>fb", "<cmd>Telescope buffers<cr>",                o)
map("n", "<leader>fh", "<cmd>Telescope help_tags<cr>",              o)

-- ── Window navigation ─────────────────────────────────────────────────────────
map("n", "<C-h>", "<C-w>h", o)
map("n", "<C-j>", "<C-w>j", o)
map("n", "<C-k>", "<C-w>k", o)
-- <C-l> repurposed for select-line (VSCode Ctrl+L); use <M-t><Right> for window right

-- ── More VSCode-style bindings ────────────────────────────────────────────────
-- Ctrl+L → select whole line (normal/insert); extend selection by one line (visual)
map("n", "<C-l>", "V",      o)
map("v", "<C-l>", "j",      o)
map("i", "<C-l>", "<C-o>V", o)

-- Ctrl+/ → toggle line comment (VSCode: editor.action.commentLine)
-- Terminals send Ctrl+/ as <C-_> (ASCII 31)
map("n", "<C-_>", function() require("Comment.api").toggle.linewise.current() end, o)
map("v", "<C-_>", function()
  local esc = vim.api.nvim_replace_termcodes("<ESC>", true, false, true)
  vim.api.nvim_feedkeys(esc, "nx", false)
  require("Comment.api").toggle.linewise(vim.fn.visualmode())
end, o)

-- Ctrl+G → go to line (VSCode: workbench.action.gotoLine)
map("n", "<C-g>", function()
  vim.ui.input({ prompt = "Go to line: " }, function(input)
    if input and input ~= "" then vim.cmd(input) end
  end)
end, o)

-- Ctrl+Shift+A → select all (VSCode: editor.action.selectAll)
map("n", "<C-S-a>", "ggVG",          o)
map("i", "<C-S-a>", "<C-o>gg<C-o>VG", o)

-- Ctrl+Enter → insert new line below, stay in insert (VSCode: editor.action.insertLineAfter)
map("n", "<C-CR>", "o",         o)
map("i", "<C-CR>", "<End><CR>", o)

-- ── Misc ──────────────────────────────────────────────────────────────────────
-- Clear search highlight; also explicitly exit visual/visual-line/visual-block
map("n", "<Esc>", "<cmd>nohlsearch<cr>", o)
map("x", "<Esc>", "<Esc>",               o)

-- Jump to matching bracket (VSCode: ctrl+m → jumpToBracket)
-- Note: <C-m> = Enter in terminals, so use <leader>m
map("n", "<leader>m", "%", o)
