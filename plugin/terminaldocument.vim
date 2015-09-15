autocmd BufEnter,BufFilePost * call s:update_document(0)
" these events might change the nature of the file,
" so we try to refresh its icon
autocmd BufWritePost,FileChangedShellPost,ShellCmdPost * call s:update_document(1)
autocmd VimLeave * call s:set_osc6('')

function! s:update_document(refresh)
  let path = expand('%:p')
  if empty(path) || !filereadable(path)
    " unnamed/unsaved file being edited
    call s:set_osc6('')
  else
    if a:refresh
      " sending an OSC with the exact same document URI won't refresh
      " the icon, so we trick Terminal with a slightly different
      " reference to the same file
      " (better than the flickering that happens when we temporarily set
      " to empty)
      call s:set_osc6('file://' . path)
    endif
    call s:set_osc6('file://' . hostname() . path)
  endif
endfunction

function! s:set_osc6(pt)
  call system('printf "\e]6;%s\a" >/dev/tty ' . shellescape(a:pt))
endfunction
