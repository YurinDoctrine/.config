" Startup Settings
	filetype plugin on
	syntax on
	let mapleader=" "
	let maplocalleader=" "
	set title
	set background=dark
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
	set autoread
	set shortmess+=c
	set ttyfast
	set showmatch
	set noshiftround
	set nostartofline
	set nolist

	if !has('gui_running')
	  set t_Co=256
	endif

" Show the complete menu when switching to insert mode.
	autocmd InsertEnter * :call feedkeys("\<C-p>")

" Navigate the complete menu items like CTRL+n / CTRL+p would.
	inoremap <expr> <Down> pumvisible() ? "<C-n>" : "<Down>"
	inoremap <expr> <Up> pumvisible() ? "<C-p>" : "<Up>"

" Select the complete menu item like CTRL+y would.
	inoremap <expr> <Right> pumvisible() ? "<C-y>" : "<Right>"
	inoremap <expr> <CR> pumvisible() ? "<C-y>" : "<CR>"
	inoremap <expr> <Tab> pumvisible() ? "<C-y>" : "<Tab>"

" Cancel the complete menu item like CTRL+e would.
	inoremap <expr> <Left> pumvisible() ? "<C-e>" : "<Left>"

" Set Ctrl-Backspace or Alt-Backspace act as delete words backwards
	inoremap <M-Backspace> <C-w>
	inoremap <C-Backspace> <C-w>

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

" Save file as doas on files that require root permission
	cabbrev w! execute 'silent! write !doas tee % >/dev/null' <bar> edit!
