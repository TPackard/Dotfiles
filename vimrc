set encoding=utf-8
set nocompatible
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

Plug 'jelera/vim-javascript-syntax'
Plug 'digitaltoad/vim-jade'

Plug 'chriskempson/base16-vim'

call plug#end()
filetype plugin indent on

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
"set cursorline

set laststatus=2

" Configure ui colors
hi StatusLine ctermbg=0
hi StatusLineNC ctermbg=0
hi TabLine ctermbg=0
hi TabLineFill ctermbg=0
hi TabLineSel ctermbg=0
hi VertSplit ctermbg=18 ctermfg=18

" Invisibles
set listchars=tab:▸\	,eol:¬

"set number
set nowrap

set hidden
set history=500

set showcmd
set splitright
set splitbelow

set incsearch
"set hlsearch

" Default to list  mode in explorer
let g:netrw_liststyle=1

" Disable scrolling, because for some reason scrolling maps to arrow keys
inoremap  <Up>     <NOP>
inoremap  <Down>   <NOP>
inoremap  <Left>   <NOP>
inoremap  <Right>  <NOP>
noremap   <Up>     <NOP>
noremap   <Down>   <NOP>
noremap   <Left>   <NOP>
noremap   <Right>  <NOP>
inoremap  <S-Up>     <NOP>
inoremap  <S-Down>   <NOP>
inoremap  <S-Left>   <NOP>
inoremap  <S-Right>  <NOP>
noremap   <S-Up>     <NOP>
noremap   <S-Down>   <NOP>
noremap   <S-Left>   <NOP>
noremap   <S-Right>  <NOP>
inoremap  <C-Up>     <NOP>
inoremap  <C-Down>   <NOP>
inoremap  <C-Left>   <NOP>
inoremap  <C-Right>  <NOP>
noremap   <C-Up>     <NOP>
noremap   <C-Down>   <NOP>
noremap   <C-Left>   <NOP>
noremap   <C-Right>  <NOP>

" set sessionoptions="blank,buffers,curdir,folds,help,tabpages,winsize"

" Tmuxline configuration
" let g:tmuxline_preset = {
	" \'a': '#S',
	" \'b': '#W',
	" \'win': '#I. #W',
	" \'cwin': '#I. #W',
	" \'z': '%l:%M %p'}
