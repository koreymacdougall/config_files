function! MarkdownLevel()
    let h = matchstr(getline(v:lnum), '^\s*#\+')
    if empty(h)
        return "="
    else
        return ">" . len(h)
    endif
endfunction

function! MyFoldText()
    let nblines = v:foldend - v:foldstart + 1
    let w = winwidth(0) - &foldcolumn - (&number ? 8 : 0) - 12
    let line = getline(v:foldstart)
    let comment = substitute(line, '/\*\|\*/\|{{{\d\=', '', 'g')
    let level = len(matchstr(getline(v:foldstart), '^#\+'))
    let level2 = repeat("  ", level)
    let expansionString = repeat(".", w - strwidth(nblines.comment.'"'))
    " let txt = '#' . level2  . comment . expansionString . nblines . " lines"
    let txt = level2  . comment . expansionString . nblines . " lines"
    return txt
endfunction


