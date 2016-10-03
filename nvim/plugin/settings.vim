"""""""""""""""""""""""""""""" Backup """"""""""""""""""""""""""""""""""""""""
set nobackup
set noswapfile

""""""""""""""""""""""""""""" Color """"""""""""""""""""""""""""""""""""""""""
colorscheme monokai

" Fold
set foldmethod=indent
set foldlevelstart=20

" Numbers
set relativenumber

set mouse=a

set clipboard=unnamed

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Generic Conf
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Sets zsh as default shell
" set shell=zsh\ -i
" set shellcmdflag=-ci
" tabs
set tabstop=4
set shiftwidth=2
set softtabstop=2
set expandtab
set autoindent
set laststatus=2
set showmatch
set incsearch
set hlsearch
" make searches case-sensitive only if they contain upper-case characters
set ignorecase smartcase
" highlight current line
set cursorline
set cmdheight=2
set switchbuf=useopen
set numberwidth=5
set showtabline=2

" Enable highlighting for syntax
syntax on
" Enable file type detection.
" Use the default filetype settings, so that mail gets 'tw' set to 72,
" 'cindent' is on in C files, etc.
" Also load indent files, to automatically do language-dependent indenting.
filetype plugin indent on
