""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" VUNDLE (https://github.com/gmarik/Vundle.vim#about)
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set rtp+=~/.vim/bundle/Vundle.vim/ " set the runtime path to include Vundle and initialize
call vundle#begin()

Plugin 'gmarik/Vundle.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-surround'
Plugin 'scrooloose/nerdtree'
Plugin 'kien/ctrlp.vim'
Plugin 'chriskempson/base16-vim'
Plugin 'xuhdev/vim-latex-live-preview'
Plugin 'godlygeek/tabular'
Plugin 'mustache/vim-mustache-handlebars'
Plugin 'pbrisbin/vim-syntax-shakespeare'
Plugin 'scrooloose/syntastic'
Plugin 'digitaltoad/vim-jade'
Plugin 'bling/vim-airline'
Plugin 'derekwyatt/vim-scala'
Plugin 'pangloss/vim-javascript'
Plugin 'plasticboy/vim-markdown'
Plugin 'mattn/emmet-vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'ekalinin/Dockerfile.vim'

call vundle#end()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" COLORSCHEME 
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set rtp+=~/.vim/bundle/vim-colors-solarized
set background=dark
colorscheme solarized
if has("syntax")
	syntax enable
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" CTRLP 
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set rtp+=~/.vim/bundle/ctrlp.vim

let g:ctrlp_cache_dir = $HOME . '/.cache/ctrlp'
if executable('ag')
	let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif
let g:ctrlp_user_command = 'ag %s -i --nocolor --nogroup --hidden
      \ --ignore .git
      \ --ignore .svn
      \ --ignore .hg
      \ --ignore .DS_Store
      \ --ignore "**/*.pyc"
      \ -g ""'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" NERDTREE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:NERDTreeWinSize = 30
let NERDTreeQuitOnOpen = 1
nnoremap ,n :NERDTree<CR>
let g:NERDTreeMapOpenSplit = '<C-x>'
let g:NERDTreeMapOpenVSplit = '<C-v>'
set encoding=utf-8

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" LATEX
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
autocmd Filetype tex setl updatetime=150
let g:livepreview_previewer = 'open -a Skim'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" SYNTACTIC
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_loc_list_height=3

let g:syntastic_python_checkers = ['flake8']
let g:syntastic_python_flake8_args='--ignore=E501,E302,E261,E701,E241,E126,E127,E128,W801,E702,E402,E251,E303,W291,W293'
let python_highlight_all=1
syntax on

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" AUTO-COMPLETE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:ycm_autoclose_preview_window_after_completion=1
nnoremap ,b :YcmCompleter GoToDefinitionElseDeclaration<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" OTHER 
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible         
filetype plugin indent on  " load filetype-specific indent files

set number          " show line numbers
set splitright
set splitbelow

set clipboard=unnamed
set showcmd         " show command in bottom bar
set cursorline      " highlight current line

set wildmenu

set tabstop=2       " The width of a TAB is set to 4.
                    " Still it is a \t. It is just that
                    " Vim will interpret it to be having
                    " a width of 4.

set shiftwidth=2    " Indents will have a width of 4

set softtabstop=2   " Sets the number of columns for a TAB

set expandtab       " Expand TABs to spaces

set textwidth=0 wrapmargin=0

let g:vim_markdown_folding_disabled = 1
