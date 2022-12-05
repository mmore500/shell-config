set laststatus=2 " Always display the statusline in all windows
set showtabline=2 " Always display the tabline, even if there is only one tab
set noshowmode " Hide the default mode text (e.g. -- INSERT -- below the statusline)
set showcmd " show commands as typed

" line jumper
" https://stackoverflow.com/a/27206531
execute "set <M-j>=\<ESC>j"
noremap <M-j> 10j
execute "set <M-k>=\<ESC>k"
noremap <M-k> 10k
map <A-Down> 10j
map <A-Up> 10k

call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-fugitive'

Plug 'vim-airline/vim-airline'

Plug 'terryma/vim-multiple-cursors'

Plug 'jeffkreeftmeijer/vim-numbertoggle'

Plug 'arcticicestudio/nord-vim'

Plug 'airblade/vim-gitgutter'

Plug 'mmore500/nerdtree'

Plug 'mmore500/nerdtree-git-plugin'

Plug 'kamykn/spelunker.vim'

" Plug 'ryanoasis/vim-devicons'

call plug#end()

let g:spelunker_check_type = 2

" https://yous.be/2014/11/30/automatically-quit-vim-if-actual-files-are-closed/
function! CheckLeftBuffers()
  if tabpagenr('$') == 1
    let i = 1
    while i <= winnr('$')
      if getbufvar(winbufnr(i), '&buftype') == 'help' ||
          \ getbufvar(winbufnr(i), '&buftype') == 'quickfix' ||
          \ exists('t:NERDTreeBufName') &&
          \   bufname(winbufnr(i)) == t:NERDTreeBufName ||
          \ bufname(winbufnr(i)) == '__Tag_List__'
        let i += 1
      else
        break
      endif
    endwhile
    if i == winnr('$') + 1
      qall
    endif
    unlet i
  endif
endfunction
autocmd BufEnter * call CheckLeftBuffers()

autocmd vimenter * NERDTree | wincmd p

set encoding=UTF-8

" let NERDTreeMinimalUI = 1
" let NERDTreeDirArrows = 1

" let g:WebDevIconsUnicodeDecorateFolderNodes = 1
" let g:DevIconsEnableFoldersOpenClose = 1

"let g:NERDTreeShowIgnoredStatus = 1  "enables ignored highlighting
let g:NERDTreeGitStatusNodeColorization = 1  "enables colorization
"let g:NERDTreeGitStatusWithFlags = 1  "enables flags, (may be default), required for colorization

"highlight link NERDTreeDir Question  "custom color
"highlight link NERDTreeGitStatusIgnored Comment  "custom color
"highlight link NERDTreeGitStatusModified cssURL  "custom color

" NERDTree
"set hidden
"let g:NERDTreeDirArrowExpandable = nr2char(8200)  "sets expandable character
"let g:NERDTreeDirArrowCollapsible = nr2char(8200)  "sets collapsible character
"let g:WebDevIconsNerdTreeAfterGlyphPadding = ''  "removes padding after devicon glyph
"let g:WebDevIconsUnicodeDecorateFolderNodes = 1  "enables decorating folder nodes

"autocmd FileType nerdtree setlocal nolist  "if you show hidden characters, this hides them in NERDTree
"let g:NERDTreeIndicatorMapCustom = {
"    \ "Modified"  : "░",
"    \ "Staged"    : ">",
"    \ "Untracked" : "_",
"    \ "Renamed"   : "▁",
"    \ "Unmerged"  : "X",
"    \ "Deleted"   : "",
"    \ "Dirty"     : "░",
"    \ "Clean"     : "  ",
"    \ 'Ignored'   : '/',
"    \ "Unknown"   : "?"
"    \ }


 let g:NERDTreeGitStatusIndicatorMapCustom = {
    \ "Modified"  : "█⫶",
    \ "Staged"    : ">>",
    \ "Untracked" : "█|",
    \ "Renamed"   : "█▁",
    \ "Unmerged"  : "XX",
    \ "Deleted"   : "██",
    \ "Dirty"     : "█░",
    \ "Clean"     : "█ ",
    \ "Ignored"   : "//",
    \ "Unknown"   : "??"
    \ }

let g:multi_cursor_use_default_mapping=0

" Default mapping
let g:multi_cursor_start_word_key      = '<C-d>'
let g:multi_cursor_select_all_word_key = '<A-n>'
let g:multi_cursor_start_key           = 'g<C-n>'
let g:multi_cursor_select_all_key      = 'g<A-n>'
let g:multi_cursor_next_key            = '<C-d>'
let g:multi_cursor_prev_key            = '<C-p>'
let g:multi_cursor_skip_key            = '<C-x>'
let g:multi_cursor_quit_key            = '<Esc>'

let g:gitgutter_sign_added = '█|'
let g:gitgutter_sign_modified = '█⫶'
let g:gitgutter_sign_removed = '█▁'
let g:gitgutter_sign_removed_first_line = '█▔'
let g:gitgutter_sign_modified_removed = "█▟"


"let g:gitgutter_highlight_lines = 1
let g:gitgutter_realtime = 1
let g:gitgutter_eager = 1
set updatetime=250

autocmd BufWritePre * :%s/\s\+$//e

set wrap linebreak nolist
set colorcolumn=80
set cursorline

set tabstop=4
set shiftwidth=4
set number relativenumber
syntax enable

colorscheme nord

function! GitStatus()
  let [a,m,r] = GitGutterGetHunkSummary()
  return printf('+%d ~%d -%d', a, m, r)
endfunction
set statusline+=%{GitStatus()}
