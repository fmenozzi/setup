set nocompatible
filetype off

" Plugins!
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'Raimondi/delimitMate'
Plugin 'airblade/vim-gitgutter'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'rust-lang/rust.vim'
Plugin 'fatih/vim-go'
Plugin 'Valloric/YouCompleteMe'
Plugin 'scrooloose/nerdtree'
Plugin 'tikhomirov/vim-glsl'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'tpope/vim-fugitive'
call vundle#end()

filetype plugin indent on
syntax on

nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

inoremap jj <esc>
inoremap <esc> <nop>

set foldmethod=indent
set foldlevel=99
nnoremap <space> za

set number

let delimitMate_expand_cr=1

let g:gitgutter_sign_column_always=1
let g:gitgutter_realtime=1
set updatetime=750

let g:ycm_global_ycm_extra_conf='~/.vim/.ycm_extra_conf.py'
let g:ycm_autoclose_preview_window_after_completion=1
let g:ycm_confirm_extra_conf=0
map f :YcmCompleter GoToDefinitionElseDeclaration<CR>

set laststatus=2
set t_Co=256

set noshowmode

set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set smarttab

set splitbelow
set splitright

set pastetoggle=<F2>
