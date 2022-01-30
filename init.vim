" styling
:colorscheme ron
:syntax on
:set fillchars=stl:\-,stlnc:\-,vert:\|
:set statusline=\ %f\ %=\ %l/%L\ 
:set showtabline=2
:hi VertSplit cterm=NONE
:hi StatusLine cterm=bold ctermfg=3 ctermbg=NONE
:hi StatusLineNC cterm=NONE ctermbg=NONE
:hi StatusLineTerm cterm=bold ctermfg=3 ctermbg=NONE
:hi StatusLineTermNC cterm=NONE ctermfg=15 ctermbg=NONE
:hi TabLineFill cterm=NONE
:hi Pmenu ctermbg=NONE ctermfg=14
:hi PmenuSel ctermbg=gray ctermfg=0

" nvim/vim defaults
:set viminfo=
:set noswapfile
:set nowrap
:set splitright
:set noautochdir
:set autoindent
:set history=0

" enable auto complete (also uses ctags)
:set omnifunc=syntaxcomplete#Complete
:filetype plugin on

" enables better 'gf' use in C/C++ code
:set path+=**4/Include,**4/include,**4/inc

" highlight useless whitespace
:highlight trailing_whitespace ctermbg=red
:match trailing_whitespace /\s\+$/

" configure then load plugins
:packadd! ftab
:packadd! fregion
:packadd! frun
:packadd! vim-cpp-modern
:packadd! brightscript.vim
:packadd! vim-fugitive

:let g:fzf_layout = {'down': '40%'}
:let $FZF_DEFAULT_COMMAND = "rg --files --ignore-case -g '!tags'"
:let $FZF_DEFAULT_OPTS = '--ansi --preview-window="right:60%" --preview="batcat --color=always --style=header,grid --line-range :300 {}" --layout reverse --margin=1,4 --bind=ctrl-s:select-all,ctrl-d:deselect-all'

" redefine :Rg to ignore ctags output
:command! -bang -nargs=? Rg
\ :call fzf#vim#grep(
\	printf("rg --column --line-number --no-heading --color=always --smart-case -g '!tags' -- %s", shellescape(<q-args>)),
\	1,
\	fzf#vim#with_preview(),
\	<bang>0
\ )

:packadd! fzf
:packadd! fzf.vim

" mappings
:let mapleader = ' '

" buffer navigation
:nnoremap <silent> <Leader>gb :bn<CR>
:nnoremap <silent> <Leader>gB :bp<CR>

" location list nagivation
:nnoremap <silent> <Leader>gl :lne<CR>
:nnoremap <silent> <Leader>gL :lN<CR>

" quickfix list navigation
:nnoremap <silent> <Leader>gc :cn<CR>
:nnoremap <silent> <Leader>gC :cN<CR>

" frun
:nnoremap <silent> <Leader>rr :Frun<CR>

" fmake
:let g:fmake_target = 'all'

:nnoremap <silent> <Leader>mm :execute printf(':make! %s', g:fmake_target)<CR>
:nnoremap          <Leader>mt :make! 
:nnoremap <silent> <Leader>ma :make! all<CR>
:nnoremap <silent> <Leader>mc :make! clean<CR>

" fzf
:nnoremap <silent> <Leader>ff :GFiles<CR>
:nnoremap <silent> <Leader>fF :Files<CR>
:nnoremap          <Leader>fg :Rg 
:nnoremap <silent> <Leader>fG :execute printf(':Rg %s', expand('<cword>'))<CR>
:nnoremap <silent> <Leader>ft :Tags<CR>
:nnoremap <silent> <Leader>fc :Commits!<CR>
:nnoremap <silent> <Leader>fb :Buffers<CR>
:nnoremap <silent> <Leader>fh :Helptags<CR>

" reload .vimrc/init.vim
:let g:fconfig = expand('<sfile>:p')
:nnoremap <silent> <Leader><C-r> :execute printf(':so %s', g:fconfig)<CR><bar>:echo printf('reloaded "%s"', g:fconfig)<CR>
