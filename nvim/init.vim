""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""" Vundle
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" set nocompatible              " be iMproved, required
" filetype plugin indent on

call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-sensible'
Plug 'flazz/vim-colorschemes'
Plug 'rking/ag.vim'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/syntastic'
Plug 'ervandew/supertab'
Plug 'chriskempson/vim-tomorrow-theme'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'Lokaltog/vim-powerline'
Plug 'tpope/vim-surround'
Plug 'bronson/vim-trailing-whitespace'
Plug 'juvenn/mustache'
Plug 'scrooloose/nerdcommenter'
Plug 'mxw/vim-jsx'
Plug 'pangloss/vim-javascript'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'terryma/vim-multiple-cursors'

call plug#end()


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

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" USER OPTIONS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Enable highlighting for syntax
syntax on
" Enable file type detection.
" Use the default filetype settings, so that mail gets 'tw' set to 72,
" 'cindent' is on in C files, etc.
" Also load indent files, to automatically do language-dependent indenting.
filetype plugin indent on

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Map Leader to comma
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let mapleader=","
set mouse=a

set clipboard=unnamed


"""""""""""""""""""""""""""""" Insert Maps """""""""""""""""""""""""""""""""""
" Line autocomplete
imap <c-l> <c-x><c-l>
"""""""""""""""""""""""""""""" Maps """"""""""""""""""""""""""""""""""""""""""
map ! :!

"""""""""""""""""""""""""""""" Leaders Maps """"""""""""""""""""""""""""""""""
" Change to alternate file
map <leader><leader> <c-^>

" Create folders
map <leader>f :!mkdir -p %%
map <leader>F :!mkdir -p

" Whitespace
map <leader>dw :FixWhitespace <CR>

".vimrc
map <silent> <leader>ev :tabnew ~/.config/nvim/init.vim<CR>
map <silent> <leader>sv :source ~/.config/nvim/init.vim<CR>

" Autoindent
map <leader>i gg=G``

" Change tab size
map <leader>ct2 :set tabstop=4 shiftwidth=2 softtabstop=2 <CR>
map <leader>ct4 :set tabstop=4 shiftwidth=4 softtabstop=4 <CR>

" Line Numbers
map <leader>lr :set relativenumber <cr>
map <leader>la :set number <cr>

" Toggle NERDTree
map <leader>n :NERDTreeToggle<cr>
map <leader>e :NERDTreeToggle %%<cr>
nnoremap <silent> - :silent edit <C-R>=empty(expand('%')) ? '.' : expand('%:p:h')<CR><CR>


"""""""""""""""""""""""""""""" Extra File extentions that use ruby syntax """""
au BufRead,BufNewFile *.rabl setf ruby

"""""""""""""""""""""""""""""" Pasting """"""""""""""""""""""""""""""""""""""""

imap <Leader>v  <C-O>:set paste<CR><C-r>*<C-O>:set nopaste<CR>

"""""""""""""""""""""""""""""" Splits """""""""""""""""""""""""""""""""""

" Move around splits with <c-hjkl>
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

set splitbelow
set splitright

"""""""""""""""""""""""""""""" Anti Arrows """""""""""""""""""""""""""""""""""
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>

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

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Rename file inline
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
cnoremap %% <C-R>=expand('%:h').'/'<cr>
" map <leader>e :edit %%
map <leader>v :view %%

function! RenameFile()
  let old_name = expand('%')
  let new_name = input('New file name: ', expand('%'), 'file')
  if new_name != '' && new_name != old_name
    exec ':saveas ' . new_name
    exec ':silent !rm ' . old_name
    redraw!
  endif
endfunction
map <leader>ee :call RenameFile()<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MULTIPURPOSE TAB KEY
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Indent if we're at the beginning of a line. Else, do completion.
function! InsertTabWrapper()
  let col = col('.') - 1
  if !col || getline('.')[col - 1] !~ '\k'
    return "\<tab>"
  else
    return "\<c-p>"
  endif
endfunction

inoremap <tab> <c-r>=InsertTabWrapper()<cr>
inoremap <s-tab> <c-n>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" FZF
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:fzf_layout = { 'down': '~40%' }

" In Neovim, you can set up fzf window using a Vim command
"let g:fzf_layout = { 'window': 'enew' }
"let g:fzf_layout = { 'window': '-tabnew' }

" Mapping selecting mappings
map <leader>r :History<CR>
map <leader>b :Buffers<CR>
map <leader>p :GFiles<CR>
map <leader>l :Lines<CR>
map <leader>a :Ag<CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" React and JSX
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:jsx_ext_required = 0

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Syntastic
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_error_symbol = '❌'
let g:syntastic_style_error_symbol = '⁉️'
let g:syntastic_warning_symbol = '⚠️'
let g:syntastic_style_warning_symbol = '💩'

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_loc_list_height = 5
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
let g:syntastic_javascript_eslint_checkers =['eslint']
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_javascript_eslint_exec = 'eslint_d'
let g:syntastic_java_checkers = ['']
let g:syntastic_disabled_filetypes=['java']

highlight link SyntasticErrorSign SignColumn
highlight link SyntasticWarningSign SignColumn
highlight link SyntasticStyleErrorSign SignColumn
highlight link SyntasticStyleWarningSign SignColumn


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Airline
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

augroup airline_config
  autocmd!
  let g:airline_enable_syntastic = 1
augroup END

