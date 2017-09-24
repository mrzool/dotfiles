" ------------------------------------------------------------
" Sections:
" - Plugins
" - General options
" - Files and buffers
" - Search and completion
" - Text and whitespace
" - User Interface
" - Abbreviations
" - Custom mappings and functions
" - Plugins Settings
"------------------------------------------------------------

if !has('nvim')
  set nocompatible
endif

filetype plugin on
filetype indent on

"------------------------------------------------------------
" Plugins

packadd minpac
call minpac#init()
call minpac#add('k-takata/minpac', {'type':'opt'})

" Libraries
call minpac#add('MarcWeber/vim-addon-mw-utils')
call minpac#add('tomtom/tlib_vim')
call minpac#add('mattn/webapi-vim')

" Color schemes
call minpac#add('chriskempson/base16-vim')
call minpac#add('pbrisbin/vim-colors-off')

" Syntax/Indenting
call minpac#add('othree/html5.vim')
call minpac#add('hail2u/vim-css3-syntax')
call minpac#add('elzr/vim-json')
call minpac#add('pangloss/vim-javascript')
call minpac#add('tpope/vim-liquid')
call minpac#add('keith/tmux.vim')
call minpac#add('tpope/vim')
call minpac#add('hdima/python-syntax')
call minpac#add('stephenway/postcss.vim')
call minpac#add('tpope/vim-markdown')
call minpac#add('mrzool/mustache.vim')
call minpac#add('StanAngeloff/php.vim')

" User Interface
call minpac#add('junegunn/goyo.vim')
call minpac#add('tpope/vim-vinegar')
call minpac#add('airblade/vim-gitgutter')
call minpac#add('sjl/gundo.vim')
call minpac#add('terryma/vim-smooth-scroll')

" Integrations
call minpac#add('vim-scripts/matchit.zip')
call minpac#add('vim-scripts/grep.vim')
call minpac#add('kien/ctrlp.vim')
call minpac#add('rking/ag.vim')
call minpac#add('Raimondi/delimitMate')
call minpac#add('scrooloose/syntastic')
call minpac#add('tpope/vim-fugitive')
call minpac#add('tpope/vim-surround')
call minpac#add('tpope/vim-repeat')
call minpac#add('tpope/vim-commentary')
call minpac#add('tpope/vim-eunuch')
call minpac#add('tpope/vim-obsession')
call minpac#add('tpope/vim-speeddating')
call minpac#add('tpope/vim-rsi')
call minpac#add('tpope/vim-dispatch')
call minpac#add('tpope/vim-ragtag')
call minpac#add('tpope/vim-unimpaired')
call minpac#add('tpope/vim-abolish')
call minpac#add('mattn/gist-vim')

" Not used atm
" call minpac#add('cakebaker/scss-syntax.vim')
" call minpac#add('tomasr/molokai')
" call minpac#add('altercation/vim-colors-solarized')
" call minpac#add('mrtazz/simplenote.vim')
" call minpac#add('junegunn/vim-xmark')
" call minpac#add('garbas/vim-snipmate')
" call minpac#add('honza/vim-snippets')
" call minpac#add('0x0dea/vim-molasses')
" call minpac#add('christoomey/vim-tmux-navigator')
" call minpac#add('benmills/vimux')
" call minpac#add('vim-pandoc/vim-pandoc')
" call minpac#add('vim-pandoc/vim-pandoc-syntax')
" call minpac#add('liamcurry/tumblr.vim')
" call minpac#add('captbaritone/better-indent-support-for-php-with-html')
" call minpac#add('rust-lang/rust.vim')
" call minpac#add('cespare/vim-toml')

" Load stock matchit.vim if no newer version available
if !exists('g:loaded_matchit') && findfile('plugin/matchit.vim', &rtp) ==# ''
  runtime! macros/matchit.vim
endif

"------------------------------------------------------------
" General options

if !has('nvim')
  set encoding=utf8
endif

set history=700
set autoread
set fileformats=unix
set dictionary=/usr/share/dict/words

set tags=tags;/

let mapleader = " "
nnoremap <SPACE> <Nop>

" Treat numerals as decimal
set nrformats -=octal

" How much time does Vim wait between keystrokes in composite commands
set ttimeout
set ttimeoutlen=100

" Persistent undos
set undodir=$HOME/.vim/tmp/undo//
set undofile
set undolevels=5000

" Save and restore marks, registers content,
" command-line history, search pattern history
set viminfo='1000,<500,:500,/500

" Get mouse working when running Vim in tmux
if !has('nvim')
  set ttymouse=xterm2
endif

" Configure backspace
set backspace=eol,start,indent
" Actually disable backspace so I just use <C-h>
inoremap <BS> <Nop>

" Jump to next/previous line when moving left/right
" set whichwrap+=<,>

" Do not store global, local values or folds in a session 
set ssop-=options
set ssop-=folds

" Activate modeline
set modeline

" Make yank repeatable with .
set cpoptions+=y

"------------------------------------------------------------
" Files and buffers

" A buffer becomes hidden when it is abandoned
set hidden

" Turn backup off
set nobackup
set nowritebackup
set noswapfile

" K opens help section for word under cursor
" useful when editing the vimrc
autocmd FileType vim setlocal keywordprg=:help

" Return to last edit position when opening files
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif

" Save all buffers when focus is lost
autocmd FocusLost * silent! wa

set autowrite

" Remember info about open buffers on close
set viminfo^=%

"------------------------------------------------------------
" Search and completion

" Substitute globally on lines
set gdefault

" Search tweaks
set ignorecase
set smartcase
set incsearch

" Turn magic on for regex
set magic

" Set path as project path and search it recursively
" (fixes 'file not found' error when using `gf`)
set path+=$PWD/**

" Autocompletion settings
set complete=.,w,b,u,t,i,t,kspell " Pull from current file, buffers in other windows and in the buffer list, and current tags
set wildmenu " Turn on wildmenu
set wildmode=longest,list:longest " How text gets replaced
set wildignore=*.o,*~,*.pyc " Ignore compiled files when autocompleting

"------------------------------------------------------------
" Text and whitespace

" Do not fold, ever
set nofoldenable

" Insert space characters whenever the tab key is pressed
set expandtab
" How many spaces for a tab
set tabstop=2
" How many spaces for indentation
set shiftwidth=2
set smarttab
" set tw=500
set autoindent
set smartindent

" Wrap related
set nowrap " Leave text alone unless otherwise specified
set textwidth=0 " Never insert line-breaks in text
set wrapmargin=0

" Wrap text in markdown, yaml and txt files
autocmd BufNewFile,BufRead,BufEnter *.md setlocal wrap linebreak
autocmd FileType markdown setlocal wrap linebreak
autocmd BufNewFile,BufRead,BufEnter *.yml setlocal wrap linebreak
autocmd FileType yaml setlocal wrap linebreak
autocmd BufNewFile,BufRead,BufEnter *.txt setlocal wrap linebreak
autocmd FileType text setlocal wrap linebreak

" Turn on spell-checking for Markdown files
autocmd BufRead,BufNewFile *.md setlocal spell

" Insert space before every line break for format=flowed to work
autocmd FileType mail setlocal formatoptions+=aw

" Highlight whitespace with symbols
set list
set listchars=eol:¬,extends:…,precedes:…,tab:\ \ 

" Makes foo-bar considered one word
" set iskeyword+=-

" Consider < and > a pair
set matchpairs+=<:>

"------------------------------------------------------------
" User Interface

" Improve smoothness
if !has('nvim')
  set ttyfast
endif

" Don't highlight search results
set nohlsearch

" Don't redraw while executing macros
set lazyredraw

" Show partially typed commands at the bottom
set showcmd

" Improves scrolling when wrap is set
" See http://vi.stackexchange.com/questions/4507/scrolling-issues-when-the-wrap-option-is-set
set display=lastline

" Keep cursor 5 lines from window borders when scrolling
set scrolloff=5

" show current position
set ruler

" Height of the command bar
set cmdheight=1

" Always show the status line
set laststatus=2

" Status line
set statusline=%t   " File name of the file in the buffer
set statusline+=%m  " Modified flag
set statusline+=%5{v:register} "Which active register
set statusline+=%=  " Align to the right from now on
set statusline+=[%{fugitive#head()}]   " Current branch
set statusline+=\ \  " Blank space
set statusline+=%y   " Type of file in the buffer
set statusline+=%5l  " Current line
set statusline+=,    " Comma
set statusline+=%c   " Current Column
set statusline+=/    " Slash
set statusline+=%-5L " Total lines
set statusline+=%p%% " Percentage through the file

" Highlight status bar when in insert mode
" if version >= 700
"   au InsertEnter * hi StatusLine ctermfg=235 ctermbg=2
"   au InsertLeave * hi StatusLine ctermbg=19 ctermfg=20
" endif

" Switch cursor shape when changing modes
if exists('$TMUX')
    let &t_SI = "\<Esc>Ptmux;\<Esc>\e[5 q\<Esc>\\"
    let &t_EI = "\<Esc>Ptmux;\<Esc>\e[2 q\<Esc>\\"
else
    let &t_SI = "\e[5 q"
    let &t_EI = "\e[2 q"
endif

" Switch cursor shape when using NeoVim
if has('nvim')
  let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
endif

" hide default mode indicator
" set noshowmode

" Number of colors
set t_Co=256

syntax enable

" Colorscheme settings
if has("unix")
  let s:uname = system("uname")
  if s:uname == "Darwin\n"
    " Settings for iTerm2 on OS X
    set background=dark
    let base16colorspace=256
    colorscheme base16-ocean
  else
    " Settings for Terminator on Linux
    let g:molokai_original=1
    let g:rehash256=1
    colorscheme molokai
    " Transparent background
    hi Normal guibg=NONE ctermbg=NONE
  endif
endif

" Display comments in italics
highlight Comment cterm=italic

" Italics and bold in markdown files
highlight htmlItalic cterm=italic
highlight htmlBold cterm=bold

" Transparency wizardry
highlight VertSplit ctermfg=244 ctermbg=NONE guibg=NONE
highlight FoldColumn ctermbg=NONE guibg=NONE
highlight LineNr ctermbg=NONE guibg=NONE
highlight GitGutterAdd ctermbg=NONE guibg=NONE
highlight GitGutterChange ctermbg=NONE guibg=NONE
highlight GitGutterDelete ctermbg=NONE guibg=NONE

" Red background for misspelled words
highlight clear SpellBad
highlight SpellBad ctermbg=01 ctermfg=00

" Line numbers tweaks
set number
set numberwidth=2
set foldcolumn=0

" Open vertical splits to the right
set splitright

" Show tab bar if there are at least two tabs
set showtabline=1

" Show matching brackets
set showmatch
set matchtime=15

" No bells
set noerrorbells
set novisualbell
set t_vb=
set timeoutlen=300

" Make links in help pages stand out
set conceallevel=0
hi link HelpBar Normal 
hi link HelpStar Normal

" Smaller help window
set helpheight=12

" Sensible horizontal scrolling
" (https://ddrscott.github.io/blog/2016/sidescroll/)
set sidescroll=1

"------------------------------------------------------------
" Abbreviations

inoreabbrev teh the
inoreabbrev usign using
inoreabbrev lokk look
inoreabbrev hwo how
inoreabbrev amoutn amount
inoreabbrev desing design
inoreabbrev fucntion function
inoreabbrev latex <span class="latex">L<sup>a</sup>T<sub>e</sub>X</span>
inoreabbrev tex <span class="latex">T<sub>e</sub>X</span>
inoreabbrev mattia@ mattia.tezzele@gmail.com

"------------------------------------------------------------
" Custom commands

" Edit vimrc
command! E execute 'edit ' . resolve(expand($MYVIMRC)) | lcd %:p:h

" minpac commands
command! PackUpdate call minpac#update()
command! PackClean call minpac#clean()

"------------------------------------------------------------
" Custom mappings

" Maps jj to esc
inoremap jj <Esc>

" Break undo sequence in insert mode when certain actions are performed
" See http://vi.stackexchange.com/questions/4556/undo-in-insert-mode/4558#455
inoremap <CR> <C-G>u<CR>
inoremap <C-R> <C-G>u<C-R>

" Remap VIM 0 to first non-blank character
noremap 0 ^

" make Y behave like D and C
nnoremap Y y$

" Insert line break
nnoremap <CR><CR> i<CR><ESC>

" Move per visual line
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk

" Move per real line
nnoremap gj j
nnoremap gk k
vnoremap gj j
vnoremap gk k

" Invert apostrophe/backtick 'jump to mark' behavior
nnoremap ' `
nnoremap ` '

" Visual mode pressing * or # searches for the current selection
vnoremap <silent> * :call VisualSelection('f', '')<CR>
vnoremap <silent> # :call VisualSelection('b', '')<CR>

" Expands path of current buffer on the command prompt
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

" Remap <c-w>o to open current buffer in a new tab
" Mimics zoom in on current split
nnoremap <c-w>o :tab sp<CR>

"------------------------------------------------------------
" Leader mappings

" Open file explorer
nnoremap <Leader>e  :e.<CR>
nnoremap <Leader>v  :Vex!<CR>
nnoremap <Leader>s  :Hex<CR>
nnoremap <Leader>t  :Tex<CR>

nnoremap <Leader>l :lcd ../
nnoremap <Leader>o :!open<Space>

" Git-related
nnoremap SS :Gstatus<CR>
nnoremap <Leader>a :exe ":GitGutterStageHunk"<CR>
nnoremap <Leader>c :Gcommit -m 
command! Preview GitGutterPreviewHunk

" Update git-gutter signs as soon as possible after stop typing event
set updatetime=1000

" Copy/paste to system clipboard
vmap <Leader>y "+y
vmap <Leader>d "+d
nmap <Leader>yy "+yy
nmap <Leader>p "+p
nmap <Leader>P "+P
vmap <Leader>p "+p
vmap <Leader>P "+P

" Toggle Gundo
nnoremap <Leader>G :GundoToggle<CR>

" Toggle Goyo
nnoremap <Leader>z :set nolist<CR>:Goyo<CR>

" Ag after selected text
vnoremap <silent> ag :call VisualSelection('gv', '')<CR>
" Search & replace selected text
vnoremap <silent> <leader>r :call VisualSelection('replace', '')<CR>

" Run :Make
nnoremap <leader>m :Make<CR>

" Enable/disable the mouse
nnoremap <leader>M :call ToggleMouse()<CR>
function! ToggleMouse()
  if &mouse == "a"
    set mouse=
  else
    set mouse=a
  endif
endfunction

" Toggle/untoggle spell checking
nnoremap <leader>ss :setlocal spell!<cr>

" Move between windows
nnoremap <C-j> <C-W>j
nnoremap <C-k> <C-W>k
nnoremap <C-h> <C-W>h
nnoremap <C-l> <C-W>l

" Run Syntastic check
nnoremap <leader>sy :SyntasticCheck<cr>

" New buffer from visual selection
vnoremap <leader>n d:new<CR>P

"------------------------------------------------------------
" Plugins Settings

" Netrw Settings
let g:netrw_preview   = 1
let g:netrw_liststyle = 3
let g:netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+'
let g:netrw_browsex_viewer = 'google-chrome'
let g:netrw_http_xcmd= "-o" " use curl to open http links
if expand('%:p:h:t') == 'dotfiles'
  let g:netrw_hide=0 " Show hidden files if I'm in my dotfiles folder
endif

" Python syntax settings
let python_version_2 = 1
let python_highlight_all = 1

" CtrlP settings
let g:ctrlp_map = 'FF'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_custom_ignore = '\v[\/](node_modules|target|dist|_site|output)|(\.(swp|ico|git|svn))$'

" Gundo settings
let g:gundo_preview_bottom = 1

" Syntastic settings
let g:syntastic_html_tidy_ignore_errors = [
			\ 'trimming empty <i>',
			\ 'trimming empty <span>',
			\ '<input> proprietary attribute \"autocomplete\"',
			\ 'proprietary attribute \"role\"',
			\ 'proprietary attribute \"hidden\"',
			\ 'proprietary attribute \"ng-',
			\ '<svg> is not recognized!',
			\ 'discarding unexpected <svg>',
			\ 'discarding unexpected </svg>',
			\ '<rect> is not recognized!',
			\ 'discarding unexpected <rect>',
			\ '<circle> is not recognized!',
			\ 'discarding unexpected <circle>',
			\ '<text> is not recognized!',
			\ 'discarding unexpected <text>',
			\ 'discarding unexpected </text>',
			\ '<path> is not recognized!',
			\ 'discarding unexpected <path>',
			\ '<desc> is not recognized!',
			\ 'discarding unexpected <desc>',
			\ 'discarding unexpected </desc>',
			\ '<g> is not recognized!',
			\ 'discarding unexpected <g>'
			\ ]

" Snipmate settings
let g:snipMate = {}
let g:snipMate.scope_aliases = {}
let g:snipMate.scope_aliases['liquid'] = 'liquid,html' " loads HTML snippets in liquid files

" Goyo settings
let g:goyo_height = 85

function! s:goyo_enter()
  set noshowmode
  set scrolloff=999
endfunction

if !exists('*s:goyo_leave')
  function! s:goyo_leave()
    source $MYVIMRC
  endfunction
endif

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()

" Gist settings
" Private Gists by default
let g:gist_post_private = 1
" Only :w! updates a gist.
let g:gist_update_on_write = 0

" Ag settings
function! CmdLine(str)
    exe "menu Foo.Bar :" . a:str
    emenu Foo.Bar
    unmenu Foo
endfunction 

function! VisualSelection(direction, extra_filter) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'b'
        execute "normal ?" . l:pattern . "^M"
    elseif a:direction == 'gv'
        call CmdLine("Ag \"" . l:pattern . "\" " )
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    elseif a:direction == 'f'
        execute "normal /" . l:pattern . "^M"
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

" vim-rsi settings
let g:rsi_no_meta = 1 " Fixes ä issue

" DelimitMate Settings
let delimitMate_expand_space = 1

" Ragtag settings
let g:ragtag_global_maps = 1

" Smooth-scroll mappings
noremap <silent> <c-u> :call smooth_scroll#up(&scroll, 25, 2)<CR>
noremap <silent> <c-d> :call smooth_scroll#down(&scroll, 25, 2)<CR>
noremap <silent> <c-b> :call smooth_scroll#up(&scroll*2, 25, 4)<CR>
noremap <silent> <c-f> :call smooth_scroll#down(&scroll*2, 25, 4)<CR>

" Set commentstring for php files
autocmd BufNewFile,BufRead,BufEnter *.php setlocal commentstring=//\ %s
autocmd FileType php setlocal commentstring=//\ %s
