:if !exists('g:fcd_use_fd')
	:let g:fcd_use_fd = 0
:endif

:if !exists('g:fcd_proto_fmt')
	:let g:fcd_proto_fmt = g:fcd_use_fd ?
	\                      'fd --type d %s' :
	\                      'find -L . -mindepth 1 \( -path "*/\.*" -o -fstype "sysfs" -o -fstype "devfs" -o -fstype "devtmpfs" -o -fstype "proc" \) -prune -o -type d %s -print 2> /dev/null | cut -b3-'
:endif

:if !exists('g:fcd_cmd')
	:let g:fcd_cmd = printf(g:fcd_proto_fmt, '')
:endif

:if !exists('g:fcd_fmt')
	:let g:fcd_fmt = printf(g:fcd_proto_fmt, g:fcd_use_fd ? ' -g -- "%s"' : '-iname "%s"')
:endif

:function! s:Fcd(path, fullscreen)
	:let l:cmd = len(a:path) > 0 ? printf(g:fcd_fmt, a:path) : g:fcd_cmd
	:let l:spec = {'source': l:cmd, 'sink': ':lcd ', 'options': ['--prompt', 'Cd> ']}

	return fzf#run(fzf#wrap(l:spec, a:fullscreen))
:endfunction

:command! -bang -complete=dir -nargs=? Fcd :call <SID>Fcd(<q-args>, <bang>0)
