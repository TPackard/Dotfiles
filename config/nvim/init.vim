set encoding=utf-8
set nocompatible
autocmd!

" Start Plug
filetype off
call plug#begin(stdpath('data') . '/plugged')

Plug 'wting/rust.vim'
Plug 'cespare/vim-toml'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'ARM9/arm-syntax-vim'
Plug 'jelera/vim-javascript-syntax'

Plug 'chriskempson/base16-vim'

call plug#end()
filetype plugin indent on

set autoread

" Persistent meta data
set viminfo='250,f1,<100,s10,:250,/5,h

set backspace=indent,eol,start

" colemak hjkl
noremap h k
noremap j h
noremap k j

" Tabs
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab

" Wrap at word boundary
set linebreak

" Syntax coloring
syntax on
set background=light
let base16colorspace=256
colorscheme base16-tylermode_light
set guicursor=
autocmd OptionSet guicursor noautocmd set guicursor=
"set cursorline

" Statusline
set laststatus=2
highlight User1 ctermfg=8 ctermbg=18
highlight User2 ctermfg=2 ctermbg=18
set statusline=%1*[%n]%*\ %f\ %2*%m%1*%h%w%r%*%=%l%1*/%*%v\ -\ %P

" Configure ui colors
hi StatusLine ctermbg=18
hi StatusLineNC ctermbg=18
hi TabLine ctermbg=0
hi TabLineFill ctermbg=0
hi TabLineSel ctermbg=0
hi VertSplit ctermbg=18 ctermfg=18
hi LineNr ctermbg=0 ctermfg=19
hi CursorLineNr ctermbg=0 ctermfg=3

" Invisibles
set listchars=tab:▸\	,eol:¬

set number
set rnu
set numberwidth=1
set nowrap

"augroup numbertoggle
"  autocmd!
"  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
"  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
"augroup END

set hidden
set history=500

set showcmd
set splitright
set splitbelow

set incsearch
set nohlsearch

" Default to list  mode in explorer
let g:netrw_liststyle=1

" set sessionoptions="blank,buffers,curdir,folds,help,tabpages,winsize"

" Enter terminal mode automatically
autocmd TermOpen * startinsert
" Escape terminal mode with <C-Space>
tnoremap <C-Space> <C-\><C-n>

" ARM highlighting for assembly files
au BufNewFile,BufRead *.s,*.S set filetype=arm " arm = armv6/7

" Tmuxline configuration
" let g:tmuxline_preset = {
	" \'a': '#S',
	" \'b': '#W',
	" \'win': '#I. #W',
	" \'cwin': '#I. #W',
	" \'z': '%l:%M %p'}
