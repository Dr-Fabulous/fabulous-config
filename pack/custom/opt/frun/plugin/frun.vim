:function! s:Frun()
	:let l:bin = exists('g:Frun_bin') ? g:Frun_bin : expand('<afile>')

	:if !executable(l:bin)
		:echoerr printf('"%s" is not executable', l:bin)
		:return
	:endif

	:execute printf('!%s %s %s',
		       \ exists('g:Frun_env') ? expand(g:Frun_env) : '',
		       \ g:Frun_bin,
		       \ exists('g:Frun_args') ? expand(g:Frun_args) : '')
:endfunction

:command! Frun :call s:Frun()
