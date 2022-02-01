:if !exists('g:Fmake_bin')
	:let g:Fmake_bin = 'make'
:endif

:if !exists('g:Fmake_default_target')
	:let g:Fmake_default_target = 'all'
:endif

:if !exists('g:Fmake_last_target')
	:let g:Fmake_last_target = 'all'
:endif

:function! s:Fmake(bang, ...)
	:if !len(a:000)
		:let g:Fmake_last_target = g:Fmake_default_target
	:else
		:let g:Fmake_last_target = join(a:000, ' ')
	:endif

	:let l:out = system(printf('%s %s', g:Fmake_bin, g:Fmake_last_target))

	:if a:bang
		:cexpr l:out
	:else
		:cgete l:out
	:endif
:endfunction

:command! -nargs=* -bang Fmake :call s:Fmake(<bang>0, <f-args>)
:command! -bang FmakeLast :call s:Fmake(<bang>0, g:Fmake_last_target)
