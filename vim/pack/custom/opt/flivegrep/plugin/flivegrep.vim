:if !exists('g:flivegrep_fmt')
	:let g:flivegrep_fmt = 'rg --column --line-number --no-heading --color=always --smart-case -- %s || :'
:endif

:function! s:FLiveGrep(query, fullscreen)
	:let l:initial_cmd = len(a:query) > 0 ? printf(g:flivegrep_fmt, a:query) : ':'
	:let l:reload_cmd = printf(g:flivegrep_fmt, ':')
	:let l:spec = {'options': ['--prompt', 'LiveGrep> ', '--phony', '--query', a:query, '--bind', 'change:reload:' . l:reload_cmd]}

	:return fzf#vim#grep(l:initial_cmd, 1, fzf#wrap(l:spec), a:fullscreen)
:endfunction

:command! -bang FLiveGrep :call <SID>FLiveGrep('', <bang>0)
:command! -bang FLiveGrepCursor :call <SID>FLiveGrep(expand('<cword>'), <bang>0)
