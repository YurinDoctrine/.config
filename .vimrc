" Startup Settings
	filetype plugin on
	syntax on
	let mapleader=" "
	set title
	set go=a
	set mouse=a
	set nohlsearch
	set clipboard+=unnamedplus
	set tabstop=4
	set softtabstop=4
	set shiftwidth=4
	set fileformat=unix
	set splitbelow splitright
	set wrap
	set noerrorbells
	set smarttab
	set smartindent
	set smartcase
	set nofoldenable
	set noswapfile
	set nobackup
	set incsearch
	set history=25
	set nocompatible
	set number relativenumber
	set encoding=utf-8
	set wildmenu
	set wildmode=longest,list,full
	set wildchar=<Tab>
	set laststatus=2
	set scrolloff=8	
	set showcmd
	set showmode
	set ttyfast
	set lazyredraw
	set nomodeline
	set secure
	set ffs=unix,dos,mac
	set completeopt=longest,menuone
	set complete-=i
	set spelllang=en_us,en_gb
	set esckeys
	set ruler

	if !has('gui_running')
	  set t_Co=256
	endif

" Disables automatic commenting on newline:
	autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
" Turns off highlighting on the bits of code that are changed, so the line that is changed is highlighted but the actual text that has changed stands out on the line and is readable.
	if &diff
	  highlight! link DiffText MatchParen
	endif
" Markdown Edits
  	let g:vim_markdown_autowrite = 1
  	let g:vim_markdown_no_extensions_in_markdown = 1
  	let g:vim_markdown_conceal = 0
  	let g:vim_markdown_override_foldtext = 0
  	let g:vim_markdown_folding_disabled = 1
" Automatically deletes all trailing whitespace and newlines at end of file on save. & reset cursor position
 	autocmd BufWritePre * let currPos = getpos(".")
	autocmd BufWritePre * %s/\s\+$//e
	autocmd BufWritePre * %s/\n\+\%$//e
  	autocmd BufWritePre *.[ch] %s/\%$/\r/e " add trailing newline for ANSI C standard
  	autocmd BufWritePre *neomutt* %s/^--$/-- /e " dash-dash-space signature delimiter in emails
  	autocmd BufWritePre * cal cursor(currPos[1], currPos[2])
" When shortcut files are updated, renew bash and ranger configs with new material:
  	autocmd BufWritePost bm-files,bm-dirs !shortcuts
" Save file as sudo on files that require root permission
	cabbrev w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!
