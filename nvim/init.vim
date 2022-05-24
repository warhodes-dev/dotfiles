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
"Plug 'vim-syntastic/syntastic'
Plug 'flazz/vim-colorschemes'
Plug 'itchyny/vim-gitbranch'
Plug 'Valloric/ListToggle'
"Plug 'rstacruz/vim-closer'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-fugitive'
Plug 'mbbill/undotree'

" LSP Stuff
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/vim-vsnip'
Plug 'simrat39/rust-tools.nvim'
Plug 'nvim-lua/popup.nvim'

Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-telescope/telescope-ui-select.nvim'
Plug 'mfussenegger/nvim-dap'

Plug 'nvim-telescope/telescope.nvim'

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

map <S-k> {
map <S-j> }
nmap <silent> <M-k> :wincmd k<CR>
nmap <silent> <M-j> :wincmd j<CR>
nmap <silent> <M-h> :wincmd h<CR>
nmap <silent> <M-l> :wincmd l<CR>
nmap <silent> <M-c> :wincmd c<CR>
nmap <silent> <M-v> :wincmd v<CR>
nmap <silent> <M-n> :wincmd <C-s><CR>

set mouse=a

"autocmd BufReadPost * if @% !~# '\.git[\/\\]COMMIT_EDITMSG$' && line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif 

au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")| exe "normal! g'\"" | endif

" Tagbar
nmap <M-1> :TagbarToggle<CR>

" NerdTree
nmap <M-3> :NERDTreeToggle<CR><a-l>

" Terminal
nmap <M-4> :split<CR>:resize 12<CR>:terminal<CR>

" Gundo
nmap <M-2> :UndotreeToggle<CR>

" Mass Move
vnoremap <c-j> :m '>+1<CR>gv=gv<c-l>
vnoremap <c-k> :m '<-2<CR>gv=gv<c-l>

" Previous Buffer
nnoremap - :b#<CR>

"Format
"au BufReadPost,BufNewFile *.rs nmap + :RustFmt<CR>

" Lightline
let g:lightline = { 
                  \ 'colorscheme': 'wombat', 
                  \ 'active': {
                  \     'left': [ [ 'mode', 'paste' ],
                  \               [ 'gitbranch', 'readonly', 'filename', 'modified' ] ],
                  \    'right': [ [ 'lineinfo' ],
                  \               [ 'percent' ],
                  \               [ 'fileformat', 'fileencoding', 'filetype' ] ]
                  \ },
                  \ 'component_function': {
                  \   'gitbranch': 'FugitiveHead'
                  \ },
                  \ }

" ListToggle
let g:lt_location_list_toggle_map = '_'

" Telescope
nnoremap [ <cmd>Telescope tags<cr>

" LSP
nnoremap <silent> ga    <cmd>lua vim.lsp.buf.code_action()<CR>
nnoremap <silent> gd    <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> gt   <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> U     <cmd>lua vim.lsp.buf.hover()<CR>

set updatetime=800

autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false})

nnoremap <silent> g[ <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
nnoremap <silent> g] <cmd>lua vim.lsp.diagnostic.goto_next()<CR>

set signcolumn=number
set completeopt=menuone,noinsert,noselect
set shortmess+=c

" Telescope
"lua <<EOF
"require('telescope').setup({
"  defaults = {
"      layout_strategy='vertical',
"  },
"})
"EOF

" LSP
lua <<EOF
local nvim_lsp = require'lspconfig'

local opts = {
    tools = { 
        autoSetHints = true,
        hover_with_actions = true,
        inlay_hints = {
            show_parameter_hints = false,
            parameter_hints_prefix = "",
            other_hints_prefix = "",
        },
    },
    server = {
        settings = {
            ["rust-analyzer"] = {
                checkOnSave = {
                    command = "clippy"
                },
            }
        }
    },
}

local signs = { Error = ">>", Warn = " >", Hint = "?", Info = "!" }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

vim.diagnostic.config({
    severity_sort = true,
})

require('rust-tools').setup(opts)
EOF

" Completion
lua <<EOF
local cmp = require'cmp'
cmp.setup({
  -- Enable LSP snippets
  snippet = {
    expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    -- Add tab support
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
    ['<Tab>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Insert,
      select = false,
    })
  },

  -- Installed sources
  sources = {
    { name = 'nvim_lsp' },
    { name = 'vsnip' },
    { name = 'path' },
    { name = 'buffer' },
  },
})
EOF
