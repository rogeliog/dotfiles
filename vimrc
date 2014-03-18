""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""" Vundle
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

filetype plugin indent on

Bundle 'scrooloose/nerdtree'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""" Generic Conf
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

runtime bundle/vim-pathogen/autoload/pathogen.vim
execute pathogen#infect('~/.vim/bundle/{}')

" Enable highlighting for syntax
syntax on
" Enable file type detection.
" Use the default filetype settings, so that mail gets 'tw' set to 72,
" 'cindent' is on in C files, etc.
" Also load indent files, to automatically do language-dependent indenting.
filetype plugin indent on

if has("gui_running")
  set guioptions=egmrt
  set guifont:Monaco:h12
endif

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8


"""""""" History """
nnoremap <F5> :GundoToggle<CR>

if exists('+colorcolumn')
  set colorcolumn=80
else
  au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
endif

"""""""""""""""""""""""""""""" Personal Stuff """""""""""""""""""""""""""""""""
let mapleader=","
set mouse=a

set clipboard=unnamed
let g:ackprg = 'ag --nogroup --nocolor --column'

"""""""""""""""""""""""""""""" Insert Maps """""""""""""""""""""""""""""""""""
" Line autocomplete
imap <c-l> <c-x><c-l>
"""""""""""""""""""""""""""""" Maps """"""""""""""""""""""""""""""""""""""""""
map ! :!

function! OpenScalaTestFile()
  let file = expand('%%')
  let test_file = substitute(file, "/main/", "/test/", "g")
  let test_file = substitute(test_file, ".scala$", "Spec.scala", "g")
  exec 'sp ' . test_file
endfunction
map <leader>. :call OpenScalaTestFile() <cr>

function! ScalaTest()
  let filename = expand('%:t')
  let new_name = substitute(filename, ".scala", "", "g")
  execute '!echo bundle exec rake ms:test['.new_name.'] > test-commands'
endfunction
"""""""""""""""""""""""""""""" Leaders Maps """"""""""""""""""""""""""""""""""
" Change to alternate file
map <leader><leader> <c-^>
" Create folders
map <leader>f :!mkdir -p %%
map <leader>F :!mkdir -p
" Whitespace
map <leader>dw :FixWhitespace <CR>
map <leader>m :map ,t :w \\|:!
map <silent> <leader>ev :tabnew ~/.vimrc <CR>
map <silent> <leader>sv :source ~/.vimrc <CR>
map <leader>i gg=G``

map <leader>ct2 :set tabstop=4 shiftwidth=2 softtabstop=2 <CR>
map <leader>ct4 :set tabstop=4 shiftwidth=4 softtabstop=4 <CR>

map <leader>lr :set relativenumber <cr>
map <leader>la :set number <cr>

map <leader>p :CtrlPCurWD<cr>
map <leader>pa :CtrlP<cr>
map <leader>r :CtrlPMRUFiles<cr>


" Toggle NERDTree
map <leader>n :NERDTreeToggle<cr>

"""""""""""""""""""""""""""""" Extra File extentions that use ruby syntax """""
au BufRead,BufNewFile *.rabl setf ruby

"""""""""""""""""""""""""""""" Pasting """"""""""""""""""""""""""""""""""""""""
"<C-O>:set paste<CR><C-r>*<C-O>:set nopaste<CR>
imap <Leader>v  <C-O>:set paste<CR><C-r>*<C-O>:set nopaste<CR>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MISC KEY MAPS
" """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <leader>y "*y
" Move around splits with <c-hjkl>
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l
" Can't be bothered to understand ESC vs <c-c> in insert mode
"
imap <c-c> <esc>
" Clear the search buffer when hitting return
function! MapCR()
  nnoremap <cr> :nohlsearch<cr>
endfunction
call MapCR()

"""""""""""""""""""""""""""""" Anti Arrows """""""""""""""""""""""""""""""""""
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>

"""""""""""""""""""""""""""""" Backup """"""""""""""""""""""""""""""""""""""""
set nobackup
set noswapfile

""""""""""""""""""""""""""""" Color """"""""""""""""""""""""""""""""""""""""""
syntax enable
set background=light
let g:solarized_termcolors=256
set t_Co=256

colorscheme Tomorrow-Night-Eighties

" Fold
set foldmethod=indent
set foldlevelstart=20

" Numbers
set relativenumber

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Gary Barnhardt
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
cnoremap %% <C-R>=expand('%:h').'/'<cr>
map <leader>e :edit %%
"map <leader>v :view %%


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

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" SWITCH BETWEEN TEST AND PRODUCTION CODE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! OpenTestAlternate()
  let new_file = AlternateForCurrentFile()
  exec ':e ' . new_file
endfunction
function! AlternateForCurrentFile()
  let current_file = expand("%")
  let new_file = current_file
  let in_spec = match(current_file, '^spec/') != -1
  let going_to_spec = !in_spec
  let in_app = match(current_file, '\<controllers\>') != -1 || match(current_file, '\<models\>') != -1 || match(current_file, '\<views\>') != -1
  if going_to_spec
    if in_app
      let new_file = substitute(new_file, '^app/', '', '')
    end
    let new_file = substitute(new_file, '\.rb$', '_spec.rb', '')
    let new_file = 'spec/' . new_file
  endif
  return new_file
endfunction
"nnoremap <leader>. :callOpenTestAlternate()<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MULTIPURPOSE TAB KEY
" Indent if we're at the beginning of a line. Else, do completion.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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
"""""""""""" Make Ctrlp Faster
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Ignore some folders and files for CtrlP indexing
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\.git$\|\.yardoc\|public$|log\|tmp$\|target$\|bin$',
  \ 'file': '\.so$\|\.dat$|\.DS_Store$|\.class$'
  \ }

" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""" Ctags
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set tagstack
set tags=tags;
