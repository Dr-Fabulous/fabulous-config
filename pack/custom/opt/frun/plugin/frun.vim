:function! s:Frun(path)
	:let l:exec = expand(exists('g:frun_exec') ? g:frun_exec : a:path)

	:if !executable(l:exec)
		:echoerr printf('"%s" is not executable', l:exec)
		:return
	:endif

	:if exists('g:frun_args')
		:execute printf(':!%s %s', l:exec, expand(join(g:frun_args, ' ')))
	:else
		:execute printf(':!%s', l:exec)
	:endif
:endfunction

:command! Frun :call s:Frun('%:p')
