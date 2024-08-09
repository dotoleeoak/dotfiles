call plug#begin()

" color scheme
Plug 'projekt0n/github-nvim-theme'

" LSP support
Plug 'neovim/nvim-lspconfig'

" language parser
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" status bar
Plug 'itchyny/lightline.vim'

" Bazel support
Plug 'google/vim-maktaba'
Plug 'bazelbuild/vim-bazel'

call plug#end()


syntax on
colorscheme github_dark

set nu               " line number
set relativenumber   " relative line number 
set autoindent       " auto indent
set cindent          " auto indent for clang
set cursorline       " highlight current line
set scrolloff=2      " lines above and below cursor

set clipboard+=unnamedplus  " enable system clipboard

" lightline setting
let g:lightline = {'colorscheme': 'wombat'}
set laststatus=2
set noshowmode

