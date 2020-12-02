set number
set list
set listchars=tab:»-,trail:-,extends:»,precedes:«,nbsp:%
set tabstop=4
set shiftwidth=4
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

set clipboard+=unnamedplus

set helplang=ja

tnoremap <silent> <ESC> <C-\><C-n>
set shell=fish

noremap : ;
noremap ; :

let mapleader = "\<Space>"
nnoremap <Leader>w :w<CR>
nnoremap <silent> <Leader>t :<C-u> terminal <CR>

" dein config
if &compatible
  set nocompatible               " Be iMproved
endif

let g:python3_host_prog ='/usr/bin/python3'

" set directory
let s:config_home	= empty($XDG_CONFIG_HOME) ? expand('~/.config') : $XDG_CONFIG_HOME
let s:cache_home	= empty($XDG_CACHE_HOME) ? expand('~/.cache') : $XDG_CACHE_HOME
let s:config_dir	= s:config_home . '/nvim'
let s:dein_dir		= s:cache_home . '/dein'
let s:dein_repo_dir	= s:dein_dir . '/repos/github.com/Shougo/dein.vim'

" auto install dein
if !isdirectory(s:dein_repo_dir)
	execute '!echo "dein is not installed. start install..."'
	execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
endif
let &runtimepath = s:dein_repo_dir .",". &runtimepath

" load dein plugins
if dein#load_state(s:dein_dir)
	call dein#begin(s:dein_dir)
	call dein#load_toml(s:config_dir . '/dein/dein.toml',      {'lazy': 0})
	call dein#load_toml(s:config_dir . '/dein/dein_lazy.toml', {'lazy': 1})
	call dein#end()
	call dein#save_state()
endif

filetype plugin indent on
syntax enable
