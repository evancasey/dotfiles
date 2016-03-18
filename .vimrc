""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" VUNDLE (https://github.com/gmarik/Vundle.vim#about)
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set rtp+=~/Dropbox/dotfiles/.vim/bundle/Vundle.vim/ " set the runtime path to include Vundle and initialize
call vundle#begin()

Plugin 'gmarik/Vundle.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-surround'
Plugin 'scrooloose/nerdtree'
Plugin 'kien/ctrlp.vim'
Plugin 'chriskempson/base16-vim'
Plugin 'mustache/vim-mustache-handlebars'
Plugin 'pbrisbin/vim-syntax-shakespeare'
Plugin 'scrooloose/syntastic'
" non-builtin syntax highlighting
Plugin 'plasticboy/vim-markdown'
Plugin 'digitaltoad/vim-jade'
Plugin 'kchmck/vim-coffee-script'
Plugin 'bling/vim-airline'
Plugin 'derekwyatt/vim-scala'
Plugin 'pangloss/vim-javascript'

call vundle#end()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" COLORSCHEME (https://github.com/chriskempson/base16-vim)
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set rtp+=~/Dropbox/dotfiles/.vim/bundle/vim-colors-solarized
set background=dark
colorscheme solarized
if has("syntax")
	syntax enable
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" CTRLP 
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set runtimepath^=~/Dropbox/dotfiles/.vim/bundle/ctrlp.vim

let g:ctrlp_cache_dir = $HOME . '/.cache/ctrlp'
if executable('ag')
	let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" NERDTREE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:NERDTreeWinSize = 30
let NERDTreeQuitOnOpen = 1
nnoremap ,n :NERDTree<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" OTHER 
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set nocompatible         
filetype plugin indent on  " load filetype-specific indent files

set number " show line numbers
set splitright
set splitbelow

set clipboard=unnamed
set showcmd " show command in bottom bar
set cursorline " highlight current line

set wildmenu

