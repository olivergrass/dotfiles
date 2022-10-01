set nocompatible            " disable compatibility to old-time vi
set showmatch               " show matching 
set ignorecase              " case insensitive 
set mouse=v                 " middle-click paste with 
set hlsearch                " highlight search 
set incsearch               " incremental search
set tabstop=4               " number of columns occupied by a tab 
set softtabstop=4           " see multiple spaces as tab-stops so <BS> does the right thing
set expandtab               " converts tabs to white space
set shiftwidth=4            " width for auto-indents
set autoindent              " indent a new line the same amount as the line just typed
set number relativenumber   " add line numbers
set wildmode=longest,list   " get bash-like tab completions
filetype plugin indent on   " allow auto-indenting depending on file type
syntax on                   " syntax highlighting
set mouse=a                 " enable mouse click
set clipboard=unnamedplus   " using system clipboard
filetype plugin on
set cursorline              " highlight current cursor-line
set ttyfast                 " Speed up scrolling in Vim
set spell                   " enable spell check (may need to download language package)
set noswapfile              " disable creating swap file
set backupdir=~/.cache/vim  " Directory to store backup files.

" LOAD PLUGINS
call plug#begin()
 Plug 'joshdick/onedark.vim'
 Plug 'mhinz/vim-startify'
 Plug 'ms-jpq/coq_nvim', {'branch': 'coq'}
 Plug 'ms-jpq/coq.artifacts', {'branch': 'artifacts'}
 Plug 'ms-jpq/chadtree', {'branch': 'chad', 'do': 'python3 -m chadtree deps'}
 Plug 'vim-airline/vim-airline' 
 Plug 'vim-airline/vim-airline-themes'
call plug#end()

" AIRLINE OPTIONS
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_theme = 'onedark'
let g:airline#extensions#tabline#formatter = 'unique_tail' " Use reasonable tab names
set showtabline=2 " Always show tabs
set noshowmode   " We don't need to see -- INSERT -- anymore

" CHADTREE OPTIONS
nnoremap <leader>v <cmd>CHADopen<cr>
let g:chadtree_settings = {'keymap.secondary': ["<m-enter>", "<middlemouse>"],'keymap.tertiary': ["<tab>", "<2-leftmouse>"]}
autocmd bufenter * if (winnr("$") == 1 && &buftype == "nofile" && &filetype == "CHADTree") | q! | endif

" COQ OPTIONS
let g:coq_settings = { 'auto_start': 'shut-up', '.display.icons.spacing': 2 }

" TAB AND BUFFER SWITCHING
nnoremap <expr> L len(gettabinfo()) > 1 ? 'gt' : ':bn<CR>'
nnoremap <expr> H len(gettabinfo()) > 1 ? 'gT' : ':bN<CR>'

colorscheme onedark
