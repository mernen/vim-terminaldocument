autocmd BufEnter,BufFilePost * call s:update_document()
autocmd VimLeave * call s:set_osc6('')

function! s:update_document()
  let path = expand('%:p')
  if empty(path)
    " unnamed file being edited
    call s:set_osc6('')
  else
    call s:set_osc6('file://' . path)
  endif
endfunction

function! s:set_osc6(pt)
  call system('printf "\e]6;%s\a" >/dev/tty ' . shellescape(a:pt))
endfunction
