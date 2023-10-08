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
	set autoindent
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
	set statusline=%<%f%m\ \[%{&ff}:%{&fenc}:%Y]\ %{getcwd()}\ \ \[%{strftime('%Y/%b/%d\ %a\ %I:%M\ %p')}\]\ %=\ Line:%l\/%L\ Column:%c%V\ %P
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
	set backspace=indent,eol,start

	if !has('gui_running')
	  set t_Co=256
	endif

" Show the complete menu when switching to insert mode or pressing space key
	autocmd InsertEnter * :call feedkeys("\<C-p>")
	inoremap <expr> <Space> pumvisible() ? "\<C-e>\<Space>" : "\<C-p>"

" Navigate the complete menu items like CTRL+n / CTRL+p would
	inoremap <expr> <Down> pumvisible() ? "<C-n>" : "<Down>"
	inoremap <expr> <Up> pumvisible() ? "<C-p>" : "<Up>"

" Select the complete menu item like CTRL+y would
	inoremap <expr> <Right> pumvisible() ? "<C-y>" : "<Right>"
	inoremap <expr> <CR> pumvisible() ? "<C-y>" : "<CR>"
	inoremap <expr> <Tab> pumvisible() ? "<C-y>" : "<Tab>"

" Cancel the complete menu item like CTRL+e would
	inoremap <expr> <Left> pumvisible() ? "<C-e>" : "<Left>"

" Set CTRL-Backspace or ALT-Backspace act as delete words backwards
	inoremap <M-Backspace> <C-w>
	inoremap <C-Backspace> <C-w>

" Undo/Redo are aliased to CTRL+z
	inoremap <C-z> <Esc>Ui

" Map CTRL+c in visual mode to copy to clipboard
	vnoremap <C-c> y:call system('xclip -selection clipboard', @")<CR>
" Map CTRL+v in insert mode to paste from clipboard
	inoremap <C-v> <C-r>=system("xclip -selection clipboard -o")<CR>

" Replace all is aliased to R
	nnoremap R :%s//g<Left><Left>

" Map CTRL+x in normal mode to CTRL+z
	nnoremap <C-z> <C-x>
	nnoremap <C-x> <C-z>

" Automatically set/unset Vim's paste mode when you paste
	let &t_SI .= "\<Esc>[?2004h"
	let &t_EI .= "\<Esc>[?2004l"

	inoremap <special> <expr> <Esc>[200~ AutoPaste()

	function! AutoPaste()
	  set pastetoggle=<Esc>[201~
	  set paste
	  return ""
	endfunction

" Turns off highlighting on the bits of code that are changed, so the line that is changed is highlighted but the actual text that has changed stands out on the line and is readable
	if &diff
	  highlight! link DiffText MatchParen
	endif

" Disables automatic commenting on newline:
	autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Automatically deletes all trailing whitespace and newlines at end of file on save & reset cursor position
 	autocmd BufWritePre * let currPos = getpos(".")
	autocmd BufWritePre * %s/\s\+$//e
	autocmd BufWritePre * %s/\n\+\%$//e
  	autocmd BufWritePre *.[ch] %s/\%$/\r/e " add trailing newline for ANSI C standard
  	autocmd BufWritePre * cal cursor(currPos[1], currPos[2])

" When shortcut files are updated, renew bash and ranger configs with new material:
  	autocmd BufWritePost bm-files,bm-dirs !shortcuts

" Save file as doas on files that require root permission
	cabbrev w! execute 'silent! write !doas tee % >/dev/null' <bar> edit!
