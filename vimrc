" GENERAL SETTINGS

set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()

" Plugins

Plugin 'gmarik/Vundle.vim'

" Colorschemes
Plugin 'altercation/vim-colors-solarized.git'
Plugin 'chriskempson/base16-vim'
Plugin 'tomasr/molokai'
Plugin 'tpope/vim-liquid'

" Syntax
Plugin 'scrooloose/syntastic.git'
Plugin 'othree/html5.vim.git'
Plugin 'cakebaker/scss-syntax.vim.git'
Plugin 'hail2u/vim-css3-syntax.git'
Plugin 'elzr/vim-json'
Plugin 'pangloss/vim-javascript'
Plugin 'StanAngeloff/php.vim'

" Interface
Plugin 'itchyny/lightline.vim'
Plugin 'junegunn/goyo.vim'

" Integrations
Plugin 'kien/ctrlp.vim'
Plugin 'mileszs/ack.vim'
Plugin 'tpope/vim-fugitive.git'
Plugin 'tpope/vim-eunuch'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-surround.git'
Plugin 'tomtom/tcomment_vim'
Plugin 'garbas/vim-snipmate.git'
Plugin 'honza/vim-snippets.git'
Plugin 'jiangmiao/auto-pairs'
Plugin 'sjl/gundo.vim'
Plugin 'vim-scripts/grep.vim'

" Others
Plugin 'MarcWeber/vim-addon-mw-utils.git'
Plugin 'vim-scripts/matchit.zip'
Plugin 'tomtom/tlib_vim.git'

call vundle#end()

filetype plugin on
filetype indent on

set encoding=utf8
set history=700
set autoread
set fileformats=unix
let mapleader = "-"
runtime macros/matchit.vim
set dictionary=/usr/share/dict/words

" Treat all numerals as decimal
set nrformats=

" Substitute globally on lines
set gdefault

" Add dictionary to default sources for autocompletion
" set complete+=k

" Persistent undos
" set undofile

" INTERFACE

" Improve smoothness
set ttyfast

" Set 7 lines to the cursor
set scrolloff=7

" Always show tab bar
set showtabline=2

" Turn on the wild menu
set wildmenu
set wildmode=list:longest

" Ignore compiled files
set wildignore=*.o,*~,*.pyc

" show current position
set ruler

" show line numbers
set number
set numberwidth=2

" Height of the command bar
set cmdheight=1

" A buffer becomes hidden when it is abandoned
set hidden

" Configure backspace
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Search tweaks
set ignorecase
set smartcase
set incsearch

" Don't redraw while executing macros
set lazyredraw

" Turn magic on for regex
set magic

" Show matching brackets
set showmatch
set matchtime=15

" No bells
set noerrorbells
set novisualbell
set t_vb=
set timeoutlen=300

" Switch cursor shape when changing modes
let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"

" Always show the status line
set laststatus=2

" hide default mode indicator
set noshowmode

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
    colorscheme base16-default
  else
    " Settings for Terminator on Linux
    let g:molokai_original=1
    let g:rehash256=1
    colorscheme molokai
    "Transparent background
    hi Normal guibg=NONE ctermbg=NONE
  endif
endif

" Transparent split separator
hi VertSplit ctermfg=244 ctermbg=NONE   cterm=bold

" Fine-tune number column
set foldcolumn=1
highlight FoldColumn ctermbg=NONE
highlight LineNr ctermbg=NONE

" let g:solarized_termcolors=256
" let g:solarized_termtrans=1
" set background=dark
" colorscheme solarized

" Configure Lightline
let g:lightline = {
      \ 'colorscheme': 'solarized',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'fugitive', 'filename', 'modified' ] ]
      \ },
      \ 'component': {
      \   'modified': '%{&filetype=="help"?"":&modified?"+":&modifiable?"":"-"}',
      \   'fugitive': '%{exists("*fugitive#head")?fugitive#head():""}'
      \ },
      \ 'component_visible_condition': {
      \   'modified': '(&filetype!="help"&&(&modified||!&modifiable))',
      \   'fugitive': '(exists("*fugitive#head") && ""!=fugitive#head())'
      \ }
      \ }


" FILES & BACKUPS

" Turn backup off
set nobackup
set nowritebackup
set noswapfile

" Do not store global, local values or folds in a session 
set ssop-=options
set ssop-=folds

" Forces *.md as markdown
autocmd BufNewFile,BufReadPost *.md set filetype=markdown

" Do not fold, ever
set nofoldenable

" TEXT & TABS

set expandtab
set smarttab
set shiftwidth=2
set tabstop=2
set linebreak
" set tw=500
set autoindent
set smartindent

" Display non-printing chars
set list
set listchars=eol:¬,extends:>,precedes:<

set wrap
autocmd FileType html setlocal nowrap
autocmd FileType liquid setlocal nowrap
autocmd FileType php setlocal nowrap

" Makes foo-bar considered one word
set iskeyword+=- 

" Turn off physical line wrapping
" set textwidth=0 
" set wrapmargin=0
" set formatoptions-=t

" Return to last edit position when opening files
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif

" Remember info about open buffers on close
set viminfo^=%

set splitright


" MAPPINGS

" Remap VIM 0 to first non-blank character
noremap 0 ^

" make y behave like other capitals
nnoremap Y y$

" Insert line break
nnoremap <CR><CR> i<CR><ESC>

" Save a file/quit
nnoremap <Leader>w :w<CR>
nnoremap <Leader>q :q<CR>

" Open file explorer quickly
nnoremap <Leader>vs :Vex!<CR>
nnoremap <Leader>sp :Sex<CR>
nnoremap <Leader>tn :Tex<CR>
nnoremap <Leader>tc :tabclose<CR>

" Resize vertical split
nnoremap <silent> <Leader>> :exe "vertical resize +5"<CR>
nnoremap <silent> <Leader>< :exe "vertical resize -5"<CR>

" HTML/CSS view
nnoremap <silent> <Leader>c :exe ":30winc >"<CR>

" Treat long lines as break lines
nnoremap j gj
nnoremap k gk

" Underline current line
nnoremap <Leader>u :Underline<CR>

" Edit/source the .vimrc
noremap <leader>ev :execute 'tabe ' . resolve(expand($MYVIMRC))<CR>
" nnoremap <leader>ev :tabe $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

" Jump to matching item with tab 
" This conflicts with the default <c-i> behavior
" nnoremap <tab> %
" vnoremap <tab> %

" Copy/paste to system clipboard
vmap <Leader>y "+y
vmap <Leader>d "+d
nmap <Leader>yy "+yy
nmap <Leader>p "+p
nmap <Leader>P "+P
vmap <Leader>p "+p
vmap <Leader>P "+P

" Expands path of current buffer on the command prompt
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

" Super-duper force write
cnoremap w!! w !sudo tee %

" Maps jj to esc
inoremap jj <Esc>

" Uppercase current word
inoremap <c-u> <esc>viwUA

" Compile TeX document
map <leader>t :! pdflatex %<CR>
map <leader>x :! xelatex %<CR>

" Invoke fugitive status window
nnoremap SS :Gstatus<CR>

" Traverse the argslist
nnoremap <leader>n :next<CR>
nnoremap <leader>N :prev<CR>

" Invert apostrophe/backtick 'jump to mark' behavior
nnoremap ' `
nnoremap ` '

" Toggle Gundo
nnoremap <Leader>g :GundoToggle<CR>

" Open Ack
nnoremap <leader>a :Ack 
" Ack after selected text
vnoremap <silent> ack :call VisualSelection('gv', '')<CR>
" Search & replace selected text
vnoremap <silent> <leader>r :call VisualSelection('replace', '')<CR>

" Enable/disable the mouse
nnoremap <leader>m :call ToggleMouse()<CR>

function! ToggleMouse()
  if &mouse == "a"
    set mouse=
  else
    set mouse=a
  endif
endfunction

" K opens help section for word under cursor
autocmd FileType vim setlocal keywordprg=:help

" Toggle/untoggle spell checking
map <leader>ss :setlocal spell!<cr>

" Visual mode pressing * or # searches for the current selection
vnoremap <silent> * :call VisualSelection('f', '')<CR>
vnoremap <silent> # :call VisualSelection('b', '')<CR>

" Map <Space> to / (search) and Ctrl-<Space> to ? (backwards search)
noremap <space> /
noremap <c-space> ?

" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugins Settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Settings for netrw
let g:netrw_preview   = 1
let g:netrw_liststyle = 3
let g:netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+'
let g:netrw_browsex_viewer = 'google-chrome'

" Run Syntastic check
map <leader>sy :SyntasticCheck<cr>

"  CtrlP settings
let g:ctrlp_map = 'FF'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_custom_ignore = '\v[\/](node_modules|target|dist|_site|output)|(\.(swp|ico|git|svn))$'

" Load HTML scope in snipmate whenever working with liquid files
let g:snipMate = {}
let g:snipMate.scope_aliases = {}
let g:snipMate.scope_aliases['liquid'] = 'liquid,html'

" Settings for Gundo
let g:gundo_preview_bottom = 1


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Command to underline the current line
function! s:Underline(chars)
  let chars = empty(a:chars) ? '-' : a:chars
  let nr_columns = virtcol('$') - 1
  let uline = repeat(chars, (nr_columns / len(chars)) + 1)
  put =strpart(uline, 0, nr_columns)
endfunction
command! -nargs=? Underline call s:Underline(<q-args>)

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
        call CmdLine("Ack \"" . l:pattern . "\" " )
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    elseif a:direction == 'f'
        execute "normal /" . l:pattern . "^M"
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction
