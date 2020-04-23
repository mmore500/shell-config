set laststatus=2 " Always display the statusline in all windows
set showtabline=2 " Always display the tabline, even if there is only one tab
set noshowmode " Hide the default mode text (e.g. -- INSERT -- below the statusline)
set showcmd " show commands as typed

" tabstop:          Width of tab character
" softtabstop:      Fine tunes the amount of white space to be added
" shiftwidth        Determines the amount of whitespace to add in normal mode
" expandtab:        When this option is enabled, vi will use spaces instead of tabs
set tabstop     =2
set softtabstop =2
set shiftwidth  =2

set expandtabif empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

Plug 'vim-airline/vim-airline'

Plug 'terryma/vim-multiple-cursors'

Plug 'jeffkreeftmeijer/vim-numbertoggle'

Plug 'arcticicestudio/nord-vim'

Plug 'preservim/nerdtree'

Plug 'Xuyuanp/nerdtree-git-plugin'

" Plug 'mhinz/vim-signify'

Plug 'airblade/vim-gitgutter'

call plug#end()

autocmd vimenter * NERDTree

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

let g:signify_realtime = 1

"let g:signify_sign_add              = '█+'
"let g:signify_sign_change           = '█>'
"let g:signify_sign_delete            = '█_'
"let g:signify_sign_delete_first_line = '█^'
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
