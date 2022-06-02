" styling
:colorscheme ron
:syntax on
:set fillchars=stl:\-,stlnc:\-,vert:\|
:set statusline=\ %{FugitiveStatusline()}\ %f\ %=\ %l/%L\ 
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
:set sessionoptions+=globals
:set guicursor=a:block,i-r-c-ci-cr:ver25

" in neovim use neovim-remote (from pip3) to open
" files in splits when the variables below are used
" in terminal buffers.
:if has('nvim')
	:set shada=
	:let $FABULOUS_NVIM_TERMINAL='1'
	:let $EDITOR='nvr -cc :vsplit --remote-wait'
	:let $VISUAL=$EDITOR
	:let $GIT_EDITOR=$EDITOR
:endif

" enables better 'gf' use in C/C++ code
:set path+=**4/Include,**4/include,**4/inc

" highlight useless whitespace
:highlight trailing_whitespace ctermbg=red
:match trailing_whitespace /\s\+$/

" configure then load plugins
:packadd! ftab
:packadd! fregion
:packadd! flivegrep
:packadd! vim-cpp-modern
:packadd! brightscript.vim
:packadd! vim-fugitive

:let g:fzf_layout = {'window': {'width': 0.95, 'height': 0.95}}

:packadd! fzf
:packadd! fzf.vim

" mappings
:let mapleader = ' '

" disable arrow keys
:nnoremap <silent> <Up> <Nop>
:nnoremap <silent> <Down> <Nop>
:nnoremap <silent> <Left> <Nop>
:nnoremap <silent> <Right> <Nop>
:tnoremap <silent> <Up> <Nop>
:tnoremap <silent> <Down> <Nop>
:tnoremap <silent> <Left> <Nop>
:tnoremap <silent> <Right> <Nop>
:xnoremap <silent> <Up> <Nop>
:xnoremap <silent> <Down> <Nop>
:xnoremap <silent> <Left> <Nop>
:xnoremap <silent> <Right> <Nop>

" term mode escape
:tnoremap <Esc><Esc> <C-\><C-n>

" buffer navigation
:nnoremap <silent> <expr> ]b printf(':%dbn<CR>', v:count1)
:nnoremap <silent> <expr> [b printf(':%dbp<CR>', v:count1)

" location list nagivation
:nnoremap <silent> <expr> ]l printf(':%dlne<CR>', v:count1)
:nnoremap <silent> <expr> [l printf(':%dlN<CR>', v:count1)

" quickfix list navigation
:nnoremap <silent> <expr> ]c printf(':%dcn<CR>', v:count1)
:nnoremap <silent> <expr> [c printf(':%dcN<CR>', v:count1)

" tag match navigation
:nnoremap <silent> <expr> ]t printf(':%dtn<CR>', v:count1)
:nnoremap <silent> <expr> [t printf(':tp<CR>', v:count1)

:nnoremap <silent> <Leader>f :Files<CR>
:nnoremap <silent> <Leader>g :FLiveGrep<CR>
:nnoremap <silent> <Leader>G :FLiveGrepCursor<CR>
:nnoremap <silent> <Leader>t :Tags<CR>
:nnoremap <silent> <Leader>c :Commits<CR>
:nnoremap <silent> <Leader>b :Buffers<CR>
:nnoremap <silent> <Leader>h :Helptags<CR>
:nnoremap <silent> <Leader>m :Marks<CR>

" reload .vimrc/init.vim
:let g:fconfig = expand('<sfile>:p')
:nnoremap <silent> <Leader><C-r> :execute printf(':so %s', g:fconfig)<CR><bar>:echo printf('reloaded "%s"', g:fconfig)<CR>
