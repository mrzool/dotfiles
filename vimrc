" Sections:
"
"    -> General
"    -> UI
"    -> Colors and Fonts
"    -> Files and backups
"    -> Text & tabs
"    -> Visual mode related
"    -> Moving around, tabs, splits and buffers
"    -> Mappings
"    -> Abbreviations
"    -> Custom commands
"    -> Spell checking
"    -> Plugins settings


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

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

set history=700

" Enable matchit plugin
runtime macros/matchit.vim

" Set to auto read when a file is changed from the outside
set autoread

" Leader key
let mapleader = "-"

" Treat all numerals as decimal
set nrformats=

" Enable the mouse
" set mouse=a

" Set dictionary
set dictionary=/usr/share/dict/words

" Add dictionary to default sources for autocompletion
" set complete+=k

" Persistent undos
" set undofile

" Substitute globally on lines
set gdefault


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => UI
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Improve smoothness
set ttyfast

" Set 7 lines to the cursor - when moving vertically using j/k
set so=7

" Always show tab bar
set showtabline=2

" Turn on the wild menu
set wildmenu
set wildmode=list:longest

" Ignore compiled files
set wildignore=*.o,*~,*.pyc

" Always show current position
set ruler

" Always show line numbers
set number
set numberwidth=3

" Height of the command bar
set cmdheight=1

" A buffer becomes hidden when it is abandoned
set hid

" Configure backspace
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Search tweaks
set ignorecase
set smartcase

" set hlsearch
set incsearch

" Don't redraw while executing macros
set lazyredraw

" Turn magic on for regex
set magic

" Show matching brackets
set showmatch
set matchtime=2

" No bells
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" Switch cursor shape when changing modes
let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"

" Always show the status line
set laststatus=2

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

" hide default mode indicator
set noshowmode

" Load molokai for selected filetypes
" autocmd BufReadPre *.md colorscheme molokai | let g:molokai_original=1 | let g:rehash256=1


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set t_Co=256

syntax enable
set encoding=utf8

" Use Unix as the standard file type
set ffs=unix,dos,mac

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

" let g:solarized_termcolors=256
" let g:solarized_termtrans=1
" set background=dark
" colorscheme solarized


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files and backups
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Turn backup off
set nobackup
set nowb
set noswapfile

" Do not store global, local values or folds in a session 
set ssop-=options    
set ssop-=folds      

" Forces *.md as markdown
autocmd BufNewFile,BufReadPost *.md set filetype=markdown

" Do not fold, ever
set nofoldenable

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text & tabs
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Use spaces instead of tabs
set expandtab

" Be smart when using tabs
set smarttab

" 1 tab == 2 spaces
set shiftwidth=2
set tabstop=2

" Linebreak on 500 characters
set lbr
set tw=500

set ai " Auto indent
set si " Smart indent
set wrap " Wrap lines
autocmd FileType html setlocal nowrap
autocmd FileType liquid setlocal nowrap
autocmd FileType php setlocal nowrap

" Makes foo-bar considered one word
set iskeyword+=- 

" Turn off physical line wrapping
set textwidth=0 
set wrapmargin=0
set formatoptions-=t

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Visual mode
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Visual mode pressing * or # searches for the current selection
vnoremap <silent> * :call VisualSelection('f', '')<CR>
vnoremap <silent> # :call VisualSelection('b', '')<CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs, splits and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Map <Space> to / (search) and Ctrl-<Space> to ? (backwards search)
noremap <space> /
noremap <c-space> ?

" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Return to last edit position when opening files
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif

" Remember info about open buffers on close
set viminfo^=%

" Open new split panes to right and bottom
" set splitbelow
set splitright


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Remap VIM 0 to first non-blank character
noremap 0 ^

" make y behave like other capitals
nnoremap Y y$

" map Enter Enter to insert line break
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

" HTML with CSS on the side
nnoremap <silent> <Leader>c :exe ":30winc >"<CR>

" Treat long lines as break lines
nnoremap j gj
nnoremap k gk

" Underline current line
nnoremap <Leader>u :Underline<CR>

" Edit and source the .vimrc
noremap <leader>ev :execute 'tabe ' . resolve(expand($MYVIMRC))<CR>
" nnoremap <leader>ev :tabe $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

" Jump to matching item with tab 
" This conflicts with the default <c-i> behavior
" nnoremap <tab> %
" vnoremap <tab> %

" Copy and paste to system clipboard
vmap <Leader>y "+y
vmap <Leader>d "+d
nmap <Leader>yy "+yy
nmap <Leader>p "+p
nmap <Leader>P "+P
vmap <Leader>p "+p
vmap <Leader>P "+P

" Expands the path of the current buffer on the command prompt with %% 
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

" Super-duper force write
cnoremap w!! w !sudo tee %

" maps jj to esc
inoremap jj <Esc>

" Uppercase current work
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

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Abbreviations
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

iabbrev zb@ zool.bib@gmail.com
iabbrev mt@ mattia.tezzele@gmail.com
iabbrev in@ info@mrzool.cc
iabbrev mrz http://mrzool.cc


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Custom Commands
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" map :C to clear last used search pattern
:command! C let @/=""



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Spell checking
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Pressing -ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>


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

" Fix 2 lines bug with supertab
" let g:SuperTabCrMapping = 0

" Settings for Gundo
nnoremap <Leader>g :GundoToggle<CR>
let g:gundo_preview_bottom = 1

" Settings for Ack
" When you press ack you Ack after the selected text
vnoremap <silent> ack :call VisualSelection('gv', '')<CR>
" Open Ack and put the cursor in the right position
map <leader>a :Ack 
" When you press <leader>r you can search and replace the selected text
vnoremap <silent> <leader>r :call VisualSelection('replace', '')<CR>

" Settings for LaTeX-Box
let g:LatexBox_latexmk_preview_continuously = 1
let g:LatexBox_quickfix = 2

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Custom functions
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
