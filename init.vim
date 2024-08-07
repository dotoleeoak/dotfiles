call plug#begin()

" color scheme
Plug 'projekt0n/github-nvim-theme'

" language parser
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" file explorer
Plug 'stevearc/oil.nvim'

" status bar
Plug 'itchyny/lightline.vim'

call plug#end()


syntax on
colorscheme github_dark

set nu           " line number
set autoindent   " auto indent
set cindent      " auto indent for clang
set cursorline   " highlight current line
set scrolloff=2  " lines above and below cursor

" lightline setting
let g:lightline = {'colorscheme': 'wombat'}
set laststatus=2
set noshowmode

