set encoding=utf-8
autocmd!

" Start Plug
filetype off
call plug#begin()

" Plug 'bling/vim-airline'
" Plug 'bling/vim-bufferline'
" Plug 'edkolev/tmuxline.vim'

" Plug 'airblade/vim-gitgutter'

" Plug 'tpope/vim-repeat'
" Plug 'tpope/vim-fugitive'

" Plug 'wting/rust.vim'
" Plug 'cespare/vim-toml'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'tikhomirov/vim-glsl'
Plug 'neovimhaskell/haskell-vim'

Plug 'jelera/vim-javascript-syntax'

Plug 'chriskempson/base16-vim'

call plug#end()
filetype plugin indent on

" Plugin configuration
" let g:airline_powerline_fonts=1
" let g:airline#extensions#bufferline=1
" let g:airline#extensions#hunks#enabled=1
" let g:airline#extensions#tabline#enabled=1
set laststatus=2

set autoread

" Sessions
nnoremap <leader>q :mksession! <CR> :qa <CR>
nnoremap <leader>wq :wa <CR> :mksession! <CR> :qa <CR>
nnoremap <leader>s :source Session.vim <CR> :1bd <CR> :noh <CR>

set backspace=indent,eol,start

" Syntax coloring
syntax on
set background=dark
let base16colorspace=256
colorscheme base16-flat
set cursorline

" Invisibles
set listchars=tab:▸\	,eol:¬

set number
set nowrap

set hidden
set history=500

set showcmd
set splitright
set splitbelow

set incsearch
set hlsearch

" Default to list  mode in explorer
let g:netrw_liststyle=1

" set sessionoptions="blank,buffers,curdir,folds,help,tabpages,winsize"

" Tmuxline configuration
" let g:tmuxline_preset = {
	" \'a': '#S',
	" \'b': '#W',
	" \'win': '#I. #W',
	" \'cwin': '#I. #W',
	" \'z': '%l:%M %p'}
