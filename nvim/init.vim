"setup vim-plug {{{
  "Note: install vim-plug if not present
  if empty(glob('~/.config/nvim/autoload/plug.vim'))
    silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall
  endif

  "Note: Skip initialization for vim-tiny or vim-small.
  if !1 | finish | endif
  if has('vim_starting')
    set nocompatible               " Be iMproved
    " Required:
    call plug#begin()
  endif
"}}}

call plug#begin(stdpath('data') . '/plugged')
Plug 'preservim/tagbar'
Plug 'preservim/nerdtree'
Plug 'rust-lang/rust.vim'
Plug 'itchyny/lightline.vim'
Plug 'vim-syntastic/syntastic'
Plug 'flazz/vim-colorschemes'
Plug 'itchyny/vim-gitbranch'
Plug 'Valloric/ListToggle'
Plug 'rstacruz/vim-closer'
call plug#end()

" General
set number
set termguicolors
set expandtab
set tabstop=4
set shiftwidth=4
set smartindent
set splitbelow
colorscheme afterglow

nmap <silent> <M-k> :wincmd k<CR>
nmap <silent> <M-j> :wincmd j<CR>
nmap <silent> <M-h> :wincmd h<CR>
nmap <silent> <M-l> :wincmd l<CR>
nmap <S-k> {
nmap <S-j> }

set mouse=a

autocmd BufReadPost * if @% !~# '\.git[\/\\]COMMIT_EDITMSG$' && line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif 

"Syntastic
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*
let g:syntastic_enable_signs = 1
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_mode_map = { 'mode': 'passive',
                  \          'active_filetypes': ['c', 'cpp', 'rust'] }
let g:syntastic_rust_checkers = ['cargo']
"let g:rust_cargo_check_examples = 1

nmap + :SyntasticCheck<CR>
nmap - :lprev<CR>
nmap = :lnext<CR>

" Tagbar
nmap <F6> :TagbarToggle<CR>

" NerdTree
nmap <F5> :NERDTree<CR><a-l>

" Terminal
nmap <F7> :split<CR>:resize 12<CR>:terminal<CR>

" Lightline
let g:lightline = { 
                  \ 'colorscheme': 'wombat', 
                  \ 'active': {
                  \     'left': [ [ 'mode', 'paste' ],
                  \               [ 'gitbranch', 'readonly', 'filename', 'modified' ] ],
                  \    'right': [ [ 'syntastic', 'lineinfo' ],
                  \               [ 'percent' ],
                  \               [ 'fileformat', 'fileencoding', 'filetype' ] ]
                  \ },
                  \ 'component_function': {
                  \     'syntastic': 'SyntasticStatuslineFlag',
                  \ },
                  \ 'component_type': {
                  \     'syntastic': 'error',
                  \ }
                  \ }
    function! SyntasticCheckHook(errors)
        call lightline#update()
    endfunction

" ListToggle
let g:lt_location_list_toggle_map = '_'







