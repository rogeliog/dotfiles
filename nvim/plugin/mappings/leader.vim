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

"""""""""""""""""""""""""""""" Pasting """"""""""""""""""""""""""""""""""""""""

imap <Leader>v  <C-O>:set paste<CR><C-r>*<C-O>:set nopaste<CR>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" FZF
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

map <leader>r :History<CR>
map <leader>b :Buffers<CR>
map <leader>p :GFiles<CR>
map <leader>l :Lines<CR>
map <leader>a :Ag<CR>

