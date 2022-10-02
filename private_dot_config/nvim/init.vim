set nocompatible            " disable compatibility to old-time vi
set showmatch               " show matching 
set ignorecase              " case insensitive 
set mouse=v                 " middle-click paste with 
set hlsearch                " highlight search 
set incsearch               " incremental search
set timeoutlen=300          " get which-key guide
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
let mapleader=" "

" LOAD PLUGINS
call plug#begin()
 Plug 'joshdick/onedark.vim'
 Plug 'mhinz/vim-startify'
 Plug 'ms-jpq/coq_nvim', {'branch': 'coq'}
 Plug 'ms-jpq/coq.artifacts', {'branch': 'artifacts'}
 Plug 'ms-jpq/chadtree', {'branch': 'chad', 'do': 'python3 -m chadtree deps'}
 Plug 'neovim/nvim-lspconfig'
 Plug 'liuchengxu/vim-which-key'
 Plug 'tpope/vim-commentary'
 Plug 'tpope/vim-fugitive'
 Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
 Plug 'junegunn/fzf.vim'
 Plug 'vim-airline/vim-airline' 
 Plug 'vim-airline/vim-airline-themes'
call plug#end()

" TAB AND BUFFER SWITCHING
nnoremap <expr> L len(gettabinfo()) > 1 ? 'gt' : ':bn<CR>'
nnoremap <expr> H len(gettabinfo()) > 1 ? 'gT' : ':bN<CR>'

" SET COLORSCHEME
colorscheme onedark

" WHICH-KEY OPTIONS
source $HOME/.config/nvim/which-key.vim

" AIRLINE OPTIONS
source $HOME/.config/nvim/airline.vim

" CHADTREE OPTIONS
let g:chadtree_settings = {'keymap.secondary': ["<m-enter>", "<middlemouse>"],'keymap.tertiary': ["<tab>", "<2-leftmouse>"]}
autocmd bufenter * if (winnr("$") == 1 && &buftype == "nofile" && &filetype == "CHADTree") | q! | endif

" COQ AND LSP OPTIONS
source $HOME/.config/nvim/coq.vim
