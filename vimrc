" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible
filetype off

" Use Vundle for all vim plugins
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Let Vundle manage itself.
Plugin 'gmarik/Vundle.vim'

" Plugins
Plugin 'kien/ctrlp.vim'
Plugin 'scrooloose/syntastic'
Plugin 'scrooloose/nerdtree'
Plugin 'Lokaltog/vim-powerline'
Plugin 'fatih/vim-go'

" Only load public version if not at work
if !filereadable(expand('~/.at_work'))
  " Non-Google only
  Plugin 'Valloric/YouCompleteMe'
endif

" Color schemes
Plugin 'altercation/vim-colors-solarized'

call vundle#end()
filetype plugin on

" ===================== ctrlp Config ====================
let ctrlp_working_path_mode = 'rc'
let g:ctrlp_custom_ignore = '\v[\/](\.git|\.hg|\.svn)$'

let g:Powerline_symbols = 'fancy'
" ================ General Config ====================

set number						"Line numbers are good
set mouse=a						"Mainly for mousewheel scrolling
set backspace=indent,eol,start	"Allow backspace in insert mode
set history=1000				"Store lots of :cmdline history
set showcmd						"Show incomplete cmds down the bottom
set showmode					"Show current mode down the bottom
set gcr=a:blinkon0				"Disable cursor blink

set autoread					"Reload files changed outside vim

" One less key to press
nmap ; :
imap jk <Esc>

" This makes vim act like all other editors, buffers can
" exist in the background without being in a window.
" http://items.sjbach.com/319/configuring-vim-right
set hidden

"turn on syntax highlighting
syntax enable

" ================ Search Settings  =================

set incsearch		"Find the next match as we type the search
set hlsearch		 "Highlight searches by default
set viminfo='100,f1  "Save up to 100 marks, enable capital marks

" ================ Turn Off Swap Files ==============

set noswapfile
set nobackup
set nowb

" ================ Persistent Undo ==================
" Keep undo history across sessions, by storing in file.
" Only works in MacVim (gui) mode.

if has('gui_running')
  set undodir=~/.vim/backups
  set undofile
endif

" ================ Indentation ======================

function! ToggleIndent()
  if &shiftwidth == 2
    set shiftwidth=4
    set softtabstop=4
  else
    set shiftwidth=2
    set shiftwidth=2
  endif
endfunction

com! Ci call ToggleIndent()

com! Trail :%s/\s\+$//g

set autoindent
set smartindent
set smarttab
set expandtab
set shiftwidth=2
set softtabstop=2
set tabstop=4

filetype plugin indent on

set nowrap  "Don't wrap lines
set linebreak  "Wrap lines at convenient points

" ================ Folds ============================

set foldmethod=indent   "fold based on indent
set nofoldenable		"dont fold by default

" ================ Completion =======================

set wildmode=list:longest
set wildmenu  "enable ctrl-n and ctrl-p to scroll thru matches
set wildignore=*.o,*.obj,*~ "stuff to ignore when tab completing
set wildignore+=*vim/backups*

" ================ Scrolling ========================

set scrolloff=8  "Start scrolling when we're 8 lines away from margins
set sidescrolloff=15
set sidescroll=1

" ================ Miscellaneous ==============

"case insensitive search
set ignorecase
set smartcase

"search/replace word under cursor
nnoremap <Leader>s :s/\<<C-r><C-w>\>/
"search/replace word under cursor whole file
nnoremap <Leader>S :%s/\<<C-r><C-w>\>/
" YCM go-to definition
nnoremap <Leader>jd :YcmCompleter GoToDefinitionElseDeclaration<CR>

" set colorscheme before highlight settings
set t_Co=16
set background=dark
colorscheme solarized

" trailing whitespace highlighting
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" Load custom local settings
if filereadable(expand("~/.vimrc_local"))
  source ~/.vimrc_local
endif
