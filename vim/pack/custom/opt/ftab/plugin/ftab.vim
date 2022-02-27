:if !exists('g:ftab_default')
	:let g:ftab_default = {
	\	'tabstop': 8,
	\	'softtabstop': 8,
	\	'shiftwidth': 8,
	\	'expandtab': 0
	\}
:endif

:if !exists('g:ftab_mappings')
	:let g:ftab_mappings = {
	\	'h': 4,
	\	'c': 4,
	\	'cpp': 4,
	\	'xml': 2,
	\	'brs': 2
	\}
:endif

:function! s:DoUseConf(tabstop, softtabstop, shiftwidth, expandtab)
	:execute printf(":set tabstop=%d softtabstop=%d shiftwidth=%d %s",
		      \ a:tabstop,
		      \ a:softtabstop,
		      \ a:shiftwidth,
		      \ a:expandtab ? 'expandtab' : 'noexpandtab')
:endfunction

:function! s:UseConf(conf)
	:if type(a:conf) == v:t_dict
		:call s:DoUseConf(a:conf.tabstop,
				\ a:conf.softtabstop,
				\ a:conf.shiftwidth,
				\ a:conf.expandtab)
	:elseif type(a:conf) == v:t_number
		:call s:DoUseConf(a:conf,
				\ a:conf,
				\ a:conf,
				\1)
	:else
		:echoerr 'Unrecognised auto-tab conf'
	:endif
:endfunction

:function! s:UseDefaults()
	:call s:UseConf(g:ftab_default)
:endfunction

:function! s:SetTabs()
	:if !has_key(g:ftab_mappings, &filetype)
		:call s:UseDefaults()
		:return
	:endif

	:call s:UseConf(g:ftab_mappings[&filetype])
:endfunction

:augroup autoTabGroup
	:autocmd!
	:autocmd FileType * :call s:SetTabs()
:augroup END
