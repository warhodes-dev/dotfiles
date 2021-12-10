call plug#begin(stdpath('data') . '/plugged')
Plug 'preservim/tagbar'
Plug 'preservim/nerdtree'
Plug 'rust-lang/rust.vim'
Plug 'itchyny/lightline.vim'
Plug 'vim-syntastic/syntastic'
Plug 'flazz/vim-colorschemes'

call plug#end()

" General
set number
set termguicolors
set expandtab
set tabstop=4
set shiftwidth=4
set smartindent
colorscheme afterglow

nmap <silent> <a-k> :wincmd k<CR>
nmap <silent> <a-j> :wincmd j<CR>
nmap <silent> <a-h> :wincmd h<CR>
nmap <silent> <a-l> :wincmd l<CR>
nmap <S-k> {
nmap <S-j> }

set mouse=a

autocmd BufReadPost * if @% !~# '\.git[\/\\]COMMIT_EDITMSG$' && line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif 

" Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" Tagbar
nmap <F6> :TagbarToggle<CR>

" NerdTree
nmap <F5> :NERDTree<CR><a-l>

" Lightline
let g:lightline = { 'colorscheme': 'powerlineish', }
