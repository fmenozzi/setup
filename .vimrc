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
call vundle#end()

" Begin actual .vimrc
filetype plugin indent on
syntax on

set number

let delimitMate_expand_cr=1

let g:gitgutter_sign_column_always=1
let g:gitgutter_realtime=1
set updatetime=750

set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set smarttab

set splitbelow
set splitright
