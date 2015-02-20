" Based on: https://github.com/amix/vimrc
"
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

" Calls Pathogen
execute pathogen#infect()

" Sets how many lines of history VIM has to remember
set history=700

" Enable filetype plugins
filetype plugin on
filetype indent on

" Enable matchit plugin
runtime macros/matchit.vim

" Set to auto read when a file is changed from the outside
set autoread

" Leader mapping
let mapleader = "-"

" Enable the mouse (pretty much only to resize splits)
set mouse=a

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => UI
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Set 7 lines to the cursor - when moving vertically using j/k
set so=7

" Always show tab bar
set showtabline=2

" Turn on the WiLd menu
set wildmenu

" Ignore compiled files
set wildignore=*.o,*~,*.pyc

"Always show current position
set ruler

"Always show line numbers
set number

" Height of the command bar
set cmdheight=1

" A buffer becomes hidden when it is abandoned
set hid

" Configure backspace
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Searching tweaks
set ignorecase
set smartcase
set hlsearch
set incsearch

" Don't redraw while executing macros
set lazyredraw

" Turn magic on for regex
set magic

" Show matching brackets
set showmatch
set mat=2

" No bells
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" Switch cursor shape with modes
let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"

" Always show the status line
set laststatus=2

" Configure Lightline
let g:lightline = {
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


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set t_Co=256

" colorscheme solarized
" set background=dark
" let g:solarized_termtrans = 1

colorscheme molokai
let g:molokai_original = 1
let g:rehash256 = 1
syntax enable
set encoding=utf8

" Use Unix as the standard file type
set ffs=unix,dos,mac


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
" autocmd BufNewFile,BufReadPost *.md set filetype=markdown

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

set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines

" Makes foo-bar considered one word
set iskeyword+=- 


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
map <space> /
map <c-space> ?

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

" Open new split panes to right and bottom (feels more natural than Vim’s default)
set splitbelow
set splitright


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Remap VIM 0 to first non-blank character
map 0 ^

" Forgive common typos
cnoreabbrev <expr> W ((getcmdtype() is# ':' && getcmdline() is# 'W')?('w'):('W'))
map q: :q

" map ctrl-J to insert line break (opposite of J)
nnoremap <NL> i<CR><ESC>

" make y behave like other capitals
map Y y$

" maps jj to esc
inoremap jj <Esc>

" Quickly save a file/quit
nnoremap <Leader>w :w<CR>
nnoremap <Leader>q :q<CR>
nnoremap <Leader>wq :wq<CR>

" Go to next occurence while vimgrepping
nnoremap <leader>n :cn<CR>
nnoremap <leader>nn :cp<CR>

" Copy and paste to system clipboard
vmap <Leader>y "+y
vmap <Leader>d "+d
nmap <Leader>yy "+yy
nmap <Leader>p "+p
nmap <Leader>P "+P
vmap <Leader>p "+p
vmap <Leader>P "+P

" Quickly open splits on netrw
nnoremap <Leader>vs :vs.<CR>
nnoremap <Leader>sp :sp.<CR>

" Resize vertical split rapidly
nnoremap <silent> <Leader>> :exe "vertical resize +5"<CR>
nnoremap <silent> <Leader>< :exe "vertical resize -5"<CR>

" HTML with CSS on the side
nnoremap <silent> <Leader>c :exe ":30winc >"<CR>

" Quickly open and close new tab
nnoremap <Leader>tn :tabnew.<CR>
nnoremap <Leader>tc :tabclose<CR>

" Treat long lines as break lines
nnoremap j gj
nnoremap k gk

" Underline current line
nnoremap <Leader>u :Underline<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Abbreviations
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

:abbr fn function


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Custom Commands
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" map :C to clear last used search pattern
:command! C let @/=""

" map :T to compile TeX file
:command! T execute "w | ! pdflatex %"


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Spell checking
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Pressing -ss will toggle and untoggle spell checking
" map <leader>ss :setlocal spell!<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugins Settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Settings for netrw
let g:netrw_preview   = 1
let g:netrw_liststyle = 3

" Run Syntastic check
map <leader>ss :SyntasticCheck<cr>

" Invoke CtrlP
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'

" Load HTML scope in snipmate whenever working with liquid files
let g:snipMate = {}
let g:snipMate.scope_aliases = {}
let g:snipMate.scope_aliases['liquid'] = 'liquid,html'

" Fix 2 lines bug with supertab
let g:SuperTabCrMapping = 0

" Settings for Ack
" When you press gv you Ack after the selected text
vnoremap <silent> av :call VisualSelection('gv', '')<CR>
" Open Ack and put the cursor in the right position
map <leader>a :Ack 
" When you press <leader>r you can search and replace the selected text
vnoremap <silent> <leader>r :call VisualSelection('replace', '')<CR>

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
