" the prefix to use for leader commands
let g:mapleader="<space>"

" Use vim-plug to manage your plugins:
" https://github.com/junegunn/vim-plug
call plug#begin()
Plug 'sheerun/vim-polyglot'
Plug 'folke/tokyonight.nvim', {'branch': 'main'}
Plug 'nvim-lualine/lualine.nvim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}}
Plug 'neoclide/coc-snippets', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-tsserver', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-prettier', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-eslint', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-tslint', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-css', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-lists', {'do': 'yarn install --frozen-lockfile'} " mru and stuff
Plug 'neoclide/coc-highlight', {'do': 'yarn install --frozen-lockfile'} " color highlighting
Plug 'Norpyx-Godot/coc-gdscript', {'do': 'yarn install --frozen-lockfile'}
Plug 'habamax/vim-godot', {'do': 'yarn install --frozen-lockfile'}
call plug#end()

set nocompatible
filetype plugin on
set secure
set number
set cursorline
syntax on
set tabstop=4
set shiftwidth=4
set expandtab
colorscheme tokyonight

