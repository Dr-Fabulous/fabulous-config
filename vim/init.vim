scriptencoding utf-8

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

:set splitright
:set noautochdir
:set autoindent
:set nowrap

" reduce disk usage
:set viminfo=
:set noswapfile

:if has('nvim')
	:set shada=
:endif

" thin cursor for insert mode, block cursor otherwise
:set guicursor=a:block,i-r-c-ci-cr:ver25

" enable fuzzy like completion with tab on commands like :find
:set path+=**
:set wildmenu
:set wildmode=longest:full,full

" make netrw not terrible to use
:let g:netrw_banner = 0
:let g:netrw_altv = 1
:let g:netrw_liststyle = 3 " tree style

" in neovim use neovim-remote (from pip3) to open
" files in splits when the variables below are used
" in terminal buffers.
:if has('nvim')
	:let $FABULOUS_NVIM_TERMINAL='1'
	:let $EDITOR='nvr -cc :vsplit --remote-wait'
	:let $VISUAL=$EDITOR
	:let $GIT_EDITOR=$EDITOR
:endif

" highlight useless whitespace
:highlight trailing_whitespace ctermbg=red
:match trailing_whitespace /\s\+$/

" configure then load plugins
:packadd! ftab
:packadd! fregion

:let g:flivegrep_use_rg = 1

:packadd! flivegrep

:let g:fcd_use_fd = 1

:packadd! fcd
:packadd! vim-cpp-modern
:packadd! brightscript.vim
:packadd! vim-fugitive

:let g:fzf_layout = {'window': {'width': 0.95, 'height': 0.95}}
:let g:fzf_preview_window = ['hidden']

:packadd! fzf
:packadd! fzf.vim

:filetype plugin on

" place certain window types on the right
:augroup FAutoRightGroup
	:autocmd!
	:autocmd FileType fugitive,git :wincmd L
	:autocmd FileType help,man :set hidden | :wincmd L
:augroup END

" mappings
:let mapleader = ' '

" escaping
:nnoremap <silent> <Esc> <Nop>
:inoremap <silent> jj <Esc>
:cnoremap <silent> jj <Esc>
:tnoremap <silent> <Esc> <C-\><C-n>

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
:nnoremap <silent> <expr> [t printf(':%dtp<CR>', v:count1)

" fzf
:nnoremap <silent> <Leader>f :Files<CR>
:nnoremap <silent> <Leader>F :GFiles<CR>
:nnoremap <silent> <Leader>g :FLiveGrep<CR>
:nnoremap <silent> <Leader>G :FLiveGrepCursor<CR>
:nnoremap <silent> <Leader>t :Tags<CR>
:nnoremap <silent> <Leader>c :Fcd<CR>
:nnoremap <silent> <Leader>C :Commits<CR>
:nnoremap <silent> <Leader>b :Buffers<CR>
:nnoremap <silent> <Leader>h :Helptags<CR>
:nnoremap <silent> <Leader>m :Marks<CR>
:nnoremap <silent> <Leader>r :History:<CR>

" reload .vimrc/init.vim
:let g:fconfig = expand('<sfile>:p')
:nnoremap <silent> <Leader><C-r> :execute printf(':so %s', g:fconfig)<CR><bar>:echo printf('reloaded "%s"', g:fconfig)<CR>
