" Automatic installation [vim-plug](github.com/junegunn/vim-plug).
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Plugins will be downloaded under the specified directory.
call plug#begin('~/.vim/plugged')

" Declare the list of plugins.
"
" Theme and ui
Plug 'altercation/vim-colors-solarized'
Plug 'vim-airline/vim-airline'
"
Plug 'tpope/vim-sensible' " Defaults everyone can agree on.
Plug 'mhinz/vim-signify'  " Show a diff using Vim its sign column.
"
" Format
Plug 'prettier/vim-prettier', { 'do': 'yarn install' }

"
" Editing
Plug 'tpope/vim-surround'           " Quoting/parenthesizing made simple.
Plug 'junegunn/vim-easy-align'      " A simple, easy-to-use Vim alignment plugin.
Plug 'jiangmiao/auto-pairs'         " Insert or delete brackets, parens, quotes in pair.
Plug 'terryma/vim-multiple-cursors' " True Sublime Text style multiple selections for Vim.
Plug 'scrooloose/nerdcommenter'     " For intensely orgasmic commenting.

" List ends here. Plugins become visible to Vim after this call.
call plug#end()

" syntax enable "Set up in vim-sensible plugin.
colorscheme solarized
set background=dark
set encoding=utf-8
set number
set relativenumber
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
" set backspace=indent,eol,start " Set up in vim-sensible plugin.
set scrolloff=100
set cursorline
set cc=80
set showmatch
set ignorecase

" Plugin Configurations
"
" vim-prettier
let g:prettier#autoformat = 0
autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.yaml,*.html PrettierAsync " Running before saving async (vim 8+)
