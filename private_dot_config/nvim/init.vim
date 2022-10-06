set nocompatible            " disable compatibility to old-time vi
set showmatch               " show matching
set ignorecase              " case insensitive
set hlsearch                " highlight search
set incsearch               " incremental search
set iskeyword+=-            " treat dash-seperated as one word
set timeoutlen=300          " get which-key guide
set updatetime=300          " faster completion
set tabstop=4               " number of columns occupied by a tab
set softtabstop=4           " see multiple spaces as tab-stops so <BS> does the right thing
set expandtab               " converts tabs to white space
set shiftwidth=4            " width for auto-indents
set nowrap                  " display one line on ONE LINE
set autoindent              " indent a new line the same amount as the line just typed
set number                  " add line numbers
set wildmode=longest,list   " get bash-like tab completions
filetype indent on          " allow auto-indenting depending on file type
filetype plugin on          " allow plugins depending on file type
syntax on                   " syntax highlighting
set clipboard=unnamedplus   " using system clipboard
set mouse=v                 " middle-click paste with
set mouse=a                 " enable mouse click
set cursorline              " highlight current cursor-line
set ttyfast                 " Speed up scrolling in Vim
set scrolloff=8             " At least 8 lines above and below cursor
set sidescrolloff=8         " - // -
set noswapfile              " disable creating swap file
set nobackup                " Recommended by coc
set nowritebackup           " Recommended by coc
let mapleader=" "

" LOAD PLUGINS
call plug#begin()
 " -- Appearance
 Plug 'joshdick/onedark.vim'
 Plug 'vim-airline/vim-airline'
 Plug 'vim-airline/vim-airline-themes'
 Plug 'edkolev/tmuxline.vim'
 Plug 'goolord/alpha-nvim'
 " -- Completion
 "  " Syntax highlight
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
    " LSP Support
    Plug 'neovim/nvim-lspconfig'
    Plug 'williamboman/mason.nvim'
    Plug 'williamboman/mason-lspconfig.nvim'
    " Autocompletion
    Plug 'hrsh7th/nvim-cmp'
    Plug 'hrsh7th/cmp-buffer'
    Plug 'hrsh7th/cmp-path'
    Plug 'saadparwaiz1/cmp_luasnip'
    Plug 'hrsh7th/cmp-nvim-lsp'
    Plug 'hrsh7th/cmp-nvim-lua'
    "  Snippets
    Plug 'L3MON4D3/LuaSnip'
    Plug 'rafamadriz/friendly-snippets'
    " All-in-one integration
    Plug 'VonHeikemen/lsp-zero.nvim'
 " -- Navigation
 Plug 'kyazdani42/nvim-web-devicons'
 Plug 'kyazdani42/nvim-tree.lua'
 Plug 'nvim-lua/plenary.nvim'
 Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.0' }
 Plug 'ahmedkhalf/project.nvim'
 Plug 'stevearc/dressing.nvim'
 " -- Tools
 Plug 'liuchengxu/vim-which-key'
 Plug 'akinsho/toggleterm.nvim'
 Plug 'tpope/vim-commentary'
 Plug 'tpope/vim-fugitive'
call plug#end()

" TAB AND BUFFER SWITCHING
nnoremap <expr> L len(gettabinfo()) > 1 ? 'gt' : ':bn<CR>'
nnoremap <expr> H len(gettabinfo()) > 1 ? 'gT' : ':bN<CR>'

" STOP PRESSING ESC
inoremap jk <Esc>
inoremap kj <Esc>

" SET COLORSCHEME
set termguicolors
colorscheme onedark

source $HOME/.config/nvim/which-key.vim
source $HOME/.config/nvim/airline.vim
source $HOME/.config/nvim/alpha.vim
source $HOME/.config/nvim/toggleterm.vim
source $HOME/.config/nvim/nvim-tree.vim
source $HOME/.config/nvim/projects.vim
source $HOME/.config/nvim/telescope.vim
source $HOME/.config/nvim/zero.vim
" source $HOME/.config/nvim/coq.vim

