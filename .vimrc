
" ################################################################################
" VUNDLE SETTINGS
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" Git plugin not hosted on GitHub
Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
" Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
" Plugin 'ascenator/L9', {'name': 'newL9'}

Plugin 'scrooloose/nerdtree'
Plugin 'tpope/vim-vinegar'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-commentary'
Plugin 'scrooloose/syntastic'
Plugin 'altercation/vim-colors-solarized'
Plugin 'kien/ctrlp.vim'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'itchyny/lightline.vim'
Plugin 'majutsushi/tagbar'
Plugin 'airblade/vim-gitgutter'
Plugin 'rafi/awesome-vim-colorschemes'
Plugin 'twerth/ir_black'
Plugin 'rainglow/vim'
Plugin 'mileszs/ack.vim'
Plugin 'aming/vim-mason'
Plugin 'abra/vim-obsidian'
Plugin 'vim-scripts/Son-of-Obisidian'
Plugin 'godlygeek/csapprox'
Plugin 'flazz/vim-colorschemes'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'junegunn/goyo.vim'
Plugin 'reedes/vim-colors-pencil'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'junegunn/fzf.vim'
Plugin 'artur-shaik/vim-javacomplete2'
Plugin 'wikitopian/hardmode.git'
Plugin 'benmills/vimux'


" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

" END OF VUNDLE DEFAULT SECTION

" CURSOR SETTINGS
" highlight Cursor guifg=white guibg=steelblue
" highlight iCursor guifg=white guibg=red
" set guicursor=a:block-Cursor
" set guicursor+=a:ver100-iCursor
" set guicursor+=a:blinkwait50
" set guicursor+=a:blinkon175

" ######################################## GLOBAL SETTINGS########################################

set directory=$HOME/.vim/swapfiles/
set rtp+=/usr/local/opt/fzf
set guifont=Consolas:h14

set t_Co=256
set encoding=utf-8

" ######################################## COSMETIC SETTINGS #####################################

colo evening
colo gruvbox

syntax on
filetype plugin indent on
set hidden
set number
set relativenumber

set guioptions-=m  "remove menu bar
set guioptions-=T  "remove toolbar
set guioptions-=r  "remove right-hand scroll bar
set guioptions-=L  "remove left-hand scroll bar

" ######################################## EDITING SETTINGS ######################################

set tabstop=4       " number of visual spaces per TAB
set softtabstop=4   " number of spaces in tab when editing
set shiftwidth=4
set expandtab       " tabs are spaces
set showcmd
set cursorline          " highlight current line
filetype indent on      " load filetype-specific indent files
set wildmenu            " visual autocomplete for command menu
set lazyredraw          " redraw only when we need to.
set showmatch           " highlight matching [{()}]
set incsearch           " search as characters are entered
set hlsearch            " highlight matches
set autoread            " auto load changed files

" ######################################## KEY MAPPINGS ######################################

inoremap jk <ESC>
let mapleader = " "

nnoremap <C-space> : CtrlPTag<CR>

map ; :Files<CR>
map , :Buffers<CR>

nnoremap <leader>e :History<cr>

nnoremap <leader>. :CtrlPTag<cr>
nnoremap <leader>z :call VimuxRunCommand("bb")<cr>
nnoremap <leader>x :call VimuxRunCommand("b && k 'p /bin/cat /bin/true;q'")<cr>
nnoremap <leader>t :call VimuxRunCommand("kt asst2")<cr>
nnoremap <leader>f ysawf
nnoremap <leader>q ysaw"

" ######################################## Ctrl P ###########################################

let g:ctrlp_match_window = 'bottom,order:ttb'
let g:ctrlp_switch_buffer = 0
let g:ctrlp_working_path_mode = 0
let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'
