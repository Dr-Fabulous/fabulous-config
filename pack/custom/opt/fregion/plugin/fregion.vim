:if !exists('g:fregion_defines')
	:let g:fregion_defines = {
	\	'brs_tag': {'file': 'syntax/brs.vim', 'hiLink': 'SpecialComment', 'start': '<\s*script.\{-}type\s*=\s*.text/brightscript[^/]\{-}>', 'end': '<\s*/script\s*>'},
	\	'js_tag': {'file': 'syntax/javascript.vim', 'hiLink': 'SpecialComment', 'start': '<\s*script\([^/]\{-}\|"[^"]\{-}"\)\{-}>', 'end': '<\s*/script\s*>'},
	\	'css_tag': {'file': 'syntax/css.vim', 'hiLink': 'SpecialComment', 'start': '<\s*style\s*>', 'end': '<\s*/style\s*>'}
	\}
:endif

:if !exists('g:fregion_mappings')
	:let g:fregion_mappings = {
	\	'xml': ['brs_tag'],
	\	'html': ['js_tag', 'css_tag']
	\}
:endif

" {file, hiLink, start, skip, end}
:function! s:ApplyDefinedRegion(name, r)
	:let l:current_syntax = b:current_syntax
	:unlet b:current_syntax

	:execute printf(':syntax include @%s %s',
		      \ a:name,
		      \ a:r.file)

	:if has_key(a:r, 'skip')
		:execute printf(":syntax region %s matchgroup=%s_group start='%s' skip='%s' end='%s' contains=@%s",
			      \ a:name,
			      \ a:name,
			      \ a:r.start,
			      \ a:r.skip,
			      \ a:r.end,
			      \ a:name)
	:else
		:execute printf(":syntax region %s matchgroup=%s_group start='%s' end='%s' contains=@%s",
			      \ a:name,
			      \ a:name,
			      \ a:r.start,
			      \ a:r.end,
			      \ a:name)
	:endif

	:execute printf(':highlight link %s_group %s',
		      \ a:name,
		      \ a:r.hiLink)

	:let b:current_syntax = l:current_syntax
:endfunction

:function! s:CheckRegions()
	:if !has_key(g:fregion_mappings, &filetype)
		:return
	:endif

	:for l:k in g:fregion_mappings[&filetype]
		:if has_key(g:fregion_defines, l:k)
			:call s:ApplyDefinedRegion(printf('%s_%s', &filetype, l:k), g:fregion_defines[l:k])
		:endif
	:endfor
:endfunction

:augroup syntaxRegionGroup
	:autocmd!
	:autocmd FileType * :call s:CheckRegions()
:augroup END
