" File:          lint.vim
" Author:        Joe Stelmach (joestelmach@gmail.com)
" Version:       0.3
" Description:   V8-powered JSHint and CSSLint Integration  
" Last Modified: May 5, 2012

" Allow the user to disable the plugin
if exists('disable_lint')
  finish
endif

" Allow continued lines.
let s:save_cpo = &cpo
set cpo&vim

if !exists("d8_command")
  let d8_command = 'd8'
endif

if !exists("lint_highlight_color")
  let lint_highlight_color = 'DarkMagenta'
endif

function! s:init()
  let b:lint_buffer = 1
  if exists('g:lint_default') && g:lint_default == 0
    let b:lint_buffer = 0
  endif
  if b:lint_buffer == 1
    call s:setupAutocommands(expand('%:e'))
  endif
endfunction

function! s:setupAutocommands(file_extension)
  augroup javaScriptLint
    au!
    if a:file_extension == 'js' || a:file_extension == 'json'
      autocmd BufWritePost,FileWritePost <buffer> call JSHint()
    elseif a:file_extension == 'css'
      autocmd BufWritePost,FileWritePost <buffer> call CSSLint()
    endif
    autocmd BufWinLeave * call s:MaybeClearCursorLineColor()
  augroup END
endfunction

function! LintVimToggle(file_extension)
  if !exists('b:lint_buffer')
    " this happens if the file is not supported (not css, js or json)
    return
  endif
  if b:lint_buffer == 0
    call s:setupAutocommands(a:file_extension)
  else
    augroup javaScriptLint 
      au!
    augroup END
  endif
  let b:lint_buffer = b:lint_buffer == 1 ? 0 : 1
endfunction

com! LintVimToggle call LintVimToggle(expand('%:e'))

autocmd BufRead *.js,*.json,*.css call s:init()

let s:dir_path = expand("<sfile>:p:h") . '/../'

" Invokes JSHint on the current file
function! JSHint() 
  call s:lint('jshint')
endfunction

" Invokes CSSHint on the current file
function! CSSLint() 
  call s:lint('csslint')
endfunction

function! s:lint(cmd)

  " if an options file has been given for this command, we use it
  if(exists('g:' . a:cmd . '_options_file'))
    execute 'let options_script = g:' . a:cmd . '_options_file'

  " otherwise we'll use the bundled options file
  else
    let options_script = s:dir_path . 'js/' . a:cmd . '/options.js' 
  endif

  let lint_script = s:dir_path . 'js/' . a:cmd . '/' . a:cmd . '.js '
  let run_script = s:dir_path . 'js/run.js -- ' . a:cmd . ' ' 
  let all_scripts = ' ' . lint_script . ' ' . options_script . ' ' .run_script
  let current_file = shellescape(expand('%:p'))
  let output = system(g:d8_command . all_scripts . current_file)
  
  " if some warnings were found, we process them
  if strlen(output) > 0

    " ensure proper error format
    let s:errorformat = "%f(%l):\%m^M"

    " write quickfix errors to a temp file 
    let quickfix_tmpfile_name = tempname()
    exe "redir! > " . quickfix_tmpfile_name
      silent echon output
    redir END

    let s:quickfix_cmd = 'cfile '
    if exists('g:lint_skip_jump_to_first_error') && g:lint_skip_jump_to_first_error
      let s:quickfix_cmd = 'cgetfile '
    endif

    " read in the errors temp file 
    execute "silent! " s:quickfix_cmd . quickfix_tmpfile_name

    " change the cursor line to something hard to miss 
    call s:SetCursorLineColor()

    " open the quicfix window
    botright copen
    let s:qfix_buffer = bufnr("$")

    " delete the temp file
    call delete(quickfix_tmpfile_name)

  " if no javascript warnings are found, we revert the cursorline color
  " and close the quick fix window
  else
    call s:ClearCursorLineColor()
    if(exists("s:qfix_buffer"))
      cclose
      unlet s:qfix_buffer
    endif
  endif

endfunction

" sets the cursor line highlight color to the error highlight color 
function! s:SetCursorLineColor() 
  " check for disabled cursor line
  if(!exists("g:lint_highlight_color") || strlen(g:lint_highlight_color) == 0) 
    return 
  endif

  call s:ClearCursorLineColor()
  let s:highlight_on = 1 

  " find the current cursor line highlight info 
  redir => l:highlight_info
    silent highlight CursorLine
  redir END

  " find the guibg property within the highlight info (if it exists)
  let l:start_index = match(l:highlight_info, "guibg")
  if(l:start_index > 0)
    let s:previous_cursor_guibg = strpart(l:highlight_info, l:start_index)

  elseif(exists("s:previous_cursor_guibg")) 
    unlet s:previous_cursor_guibg
  endif

  execute "highlight CursorLine guibg=" . g:lint_highlight_color
endfunction

" Conditionally reverts the cursor line color based on the presence
" of the quickfix window
function! s:MaybeClearCursorLineColor()
  if(exists("s:qfix_buffer") && s:qfix_buffer == bufnr("%"))
    call s:ClearCursorLineColor()
  endif
endfunction

" Reverts the cursor line color
function! s:ClearCursorLineColor()
  " only revert if our highlight is currently enabled
  if(exists("s:highlight_on") && s:highlight_on) 
    let s:highlight_on = 0 

    " if a previous cursor guibg color was recorded, we use it
    if(exists("s:previous_cursor_guibg")) 
      execute "highlight CursorLine " . s:previous_cursor_guibg
      unlet s:previous_cursor_guibg

    " otherwise, we clear the curor line highlight entirely
    else
      highlight clear CursorLine 
    endif
  endif
endfunction

" Restore cpo value
let &cpo = s:save_cpo
unlet s:save_cpo
" vim: set et sw=2 sts=2:
