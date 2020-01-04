fu man#zsh#main(kwd) abort "{{{1
    sil let s:pages = systemlist('man -s1 -Kw '..shellescape(a:kwd)..' | grep zsh')
    call map(s:pages, {_,v -> matchstr(v, '.*/\zs.\{-}\ze\.')})
    call filter(s:pages, {_,v -> v !~# '\m\C^No manual entry for' && v isnot# ''})
    if len(s:pages) == 0
        return
    endif
    let s:pos = 0
    exe 'Man '..s:pages[0]
endfu

fu man#zsh#move_in_pages(dir) abort "{{{1
    if len(s:pages) == 0
        return
    endif
    let s:pos = (s:pos + (a:dir is# 'fwd' ? 1 : -1)) % len(s:pages)
    exe 'Man '..s:pages[s:pos]
endfu

