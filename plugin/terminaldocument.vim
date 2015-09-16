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
    let path = s:urlencode(path)
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


" Percent-encodes any characters that cannot appear in a URI
"
" Examples:
"   s:urlencode('/Users/foo/bar.txt') = '/Users/foo/bar.txt'
"   s:urlencode('/Users/foo/bar baz.txt') = '/Users/foo/bar%20baz.txt'
"   s:urlencode('/Users/foo/bár.txt') = '/Users/foo/b%c3%a1r.txt'
function! s:urlencode(s)
  return substitute(a:s, '[^a-z0-9/._-]', '\=s:encode_char(submatch(0))', 'gi')
endfunction

" Encodes a character as a series of percent-encoded UTF-8 bytes
"
" Examples:
"   s:encode_char('@') = '%40'
"   s:encode_char('é') = '%c3%a9'
"
" (breaks if your encoding is not UTF-8)
function! s:encode_char(c)
  let i = 0
  let len = len(a:c)
  let out = ''
  while i < len
    let out .= printf('%%%02x', char2nr(a:c[i]))
    let i += 1
  endwhile
  return out
endfunction
