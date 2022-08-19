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
" Coding
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'ekalinin/Dockerfile.vim'     " Vim syntax file for Docker's Dockerfile and snippets for snipMate.
"
" Plugin 'SirVer/ultisnips'        " The ultimate solution for snippets in Vim.
" Plugin 'honza/vim-snippets'      " The ultimate solution for snippets in Vim.
"

" Editing
Plug 'kamykn/spelunker.vim'         " Plugin that improves Vim's spell checking function.
Plug 'tpope/vim-surround'           " Quoting/parenthesizing made simple.
Plug 'junegunn/vim-easy-align'      " A simple, easy-to-use Vim alignment plugin.
Plug 'jiangmiao/auto-pairs'         " Insert or delete brackets, parens, quotes in pair.
Plug 'mg979/vim-visual-multi'       " True Sublime Text style multiple selections for Vim.
Plug 'scrooloose/nerdcommenter'     " For intensely orgasmic commenting.
Plug 'preservim/nerdtree'           " A file system explorer for the Vim editor.
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'             " A general-purpose command-line fuzzy finder.
Plug 'dense-analysis/ale'           " Check syntax in Vim asynchronously and fix files, with Language Server Protocol (LSP) support.
Plug 'easymotion/vim-easymotion'    " Provides a much simpler way to use some motions in vim.

" When started with plain Vim, the plugin is not registered
" and PlugClean will try to remove it
if has('nvim')
  Plug 'neovim/nvim-lspconfig'      " Quickstart configurations for the Nvim LSP client.
  Plug 'hrsh7th/cmp-nvim-lsp'       " nvim-cmp source for neovim's built-in language server client.
  Plug 'hrsh7th/cmp-buffer'         " nvim-cmp source for buffer words
  Plug 'hrsh7th/cmp-path'           " nvim-cmp source for filesystem paths.
  Plug 'hrsh7th/cmp-cmdline'        " nvim-cmp source for vim's cmdline.
  Plug 'hrsh7th/nvim-cmp'           " A completion engine plugin for neovim written in Lua.

  " For ultisnips users.
  " Plug 'quangnguyen30192/cmp-nvim-ultisnips'

  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} " Treesitter configurations and abstraction layer for Neovim.
else
  Plug 'ycm-core/YouCompleteMe', { 'do': './install.py --go-completer --ts-completer' }
endif

" List ends here. Plugins become visible to Vim after this call.
call plug#end()

colorscheme solarized

set background=dark       " Tell vim what the background color looks like
set encoding=utf-8        " The encoding displayed
set number                " Line numbers
set relativenumber
set tabstop=2             " Insert 2 spaces for a tab
set softtabstop=2
set shiftwidth=2          " Change the number of space characters inserted for indentation
set expandtab             " Converts tabs to spaces
set scrolloff=100
set cursorline            " Enable highlighting of the current line
set cc=80,120
set showmatch
set ignorecase
set smartcase
set splitbelow            " Horizontal splits will automatically be below
set splitright            " Vertical splits will automatically be to the right
" set clipboard=unnamedplus " Copy paste between vim and everything else

" Plugin Configurations
"
" vim-prettier
let g:prettier#autoformat = 0
autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.yaml,*.html PrettierAsync " Running before saving async (vim 8+)

" scrooloose/nerdcommenter
filetype plugin on
" add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
" align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'
" allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1

" preservim/nerdtree
let NERDTreeShowHidden=1          " Show hidden files
map <C-b> :NERDTreeToggle<CR>
" exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
" open the existing NERDTree on each new tab.
autocmd BufWinEnter * if getcmdwintype() == '' | silent NERDTreeMirror | endif

" junegunn/fzf.vim
nmap <C-p> :GFiles<CR>

" kamykn/spelunker.vim
let g:spelunker_check_type = 2  " Spellcheck displayed words in buffer. Fast and dynamic.

" dense-analysis/ale
let g:ale_sign_error = '🚨'     " https://github.com/dense-analysis/ale#5v-how-can-i-change-the-signs-ale-uses
let g:ale_sign_warning = '⚠️'    " https://github.com/dense-analysis/ale#5v-how-can-i-change-the-signs-ale-uses
let g:ale_lint_on_enter = 0     " Don not run linters on opening a file.
" let g:ale_linters_explicit = 1  " Only run linters named in ale_linters settings
let g:ale_linters = {
\ 'javascript': ['cspell', 'eslint', 'tsserver'],
\ 'typescript': ['cspell', 'eslint', 'tsserver', 'typecheck'],
\}

" easymotion/vim-easymotion
let g:EasyMotion_smartcase = 1          " Turn on case-insensitive feature

" junegunn/vim-easy-align
  " Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
  " Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" Vim Configurations
"
" map the leader key to ","
let mapleader = ","

" resize splits when the window is resized
au VimResized * :wincmd =

" Move lines up or down with alt + j/k
nnoremap ∆ :m .+1<CR>==
nnoremap ˚ :m .-2<CR>==
inoremap ∆ <Esc>:m .+1<CR>==gi
inoremap ˚ <Esc>:m .-2<CR>==gi
vnoremap ∆ :m '>+1<CR>gv=gv
vnoremap ˚ :m '<-2<CR>gv=gv

" Go to home and end using capitalized directions
noremap H ^
noremap L $
