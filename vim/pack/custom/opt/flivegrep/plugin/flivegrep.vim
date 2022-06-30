:if !exists('g:flivegrep_use_rg')
	:let g:flivegrep_use_rg = 0
:endif

:if !exists('g:flivegrep_fmt')
	:let g:flivegrep_fmt = g:flivegrep_use_rg ?
	\                      'rg --column --line-number --no-heading --color=always --smart-case -- %s || true' :
	\                      'grep -niR -- %s || true'
:endif

:function! s:FLiveGrep(query, fullscreen)
	:let l:initial_cmd = len(a:query) > 0 ? printf(g:flivegrep_fmt, '"' . a:query . '"') : 'true'
	:let l:reload_cmd = printf(g:flivegrep_fmt, '{q}')
	:let l:spec = {'options': ['--prompt', 'LiveGrep> ', '--phony', '--query', a:query, '--bind', 'change:reload:' . l:reload_cmd]}

	:return fzf#vim#grep(l:initial_cmd, 1, fzf#vim#with_preview(l:spec), a:fullscreen)
:endfunction

:command! -bang -nargs=? FLiveGrep :call <SID>FLiveGrep(<q-args>, <bang>0)
:command! -bang FLiveGrepCursor :call <SID>FLiveGrep(expand('<cword>'), <bang>0)
