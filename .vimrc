" Startup Settings
	syntax on
	let mapleader=" "
	set title
	set go=a
	set mouse=a
	set nohlsearch
	set clipboard=unnamedplus
	set tabstop=4
	set softtabstop=4
	set shiftwidth=4
	set fileformat=unix
	set splitbelow splitright
	set noerrorbells
	set tabstop=2 softtabstop=2
	set shiftwidth=2
	set expandtab
	set smartindent
	set nofoldenable
	set nowrap
	set smartcase
	set noswapfile
	set nobackup
	set incsearch
	set history=25
	set nocompatible
	set number relativenumber
	filetype plugin on
	set encoding=utf-8
	set wildmenu
	set wildmode=longest,list,full
	set laststatus=2
	set scrolloff=8	
	set showcmd
	set showmode

	if !has('gui_running')
	  set t_Co=256
	endif

	autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
" Persistent_undo
	set undodir=~/.vim/undodir"
	set undofile
	let g:undotree_WindowLayout = 2
" Markdown Edits
  	let g:vim_markdown_autowrite = 1
  	let g:vim_markdown_no_extensions_in_markdown = 1
  	let g:vim_markdown_conceal = 0
  	let g:vim_markdown_override_foldtext = 0
  	let g:vim_markdown_folding_disabled = 1
" Automatically deletes all trailing whitespace on save & reset cursor position.
 	autocmd BufWritePre * let currPos = getpos(".")
	autocmd BufWritePre * %s/\s\+$//e
    	autocmd BufWritePre * %s/\n\+\%$//e
    	autocmd BufWritePre *.[ch] %s/\%$/\r/e
  	autocmd BufWritePre * cal cursor(currPos[1], currPos[2])
" When shortcut files are updated, renew bash and ranger configs with new material:
  	autocmd BufWritePost bm-files,bm-dirs !shortcuts
