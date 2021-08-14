:syntax enable
:colorscheme ron

:highlight TabLineFill cterm=NONE " transparent background tabbar
:highlight VertSplit cterm=NONE " transparent background vsplits
:highlight StatusLine cterm=NONE ctermfg=3 " transparent background statusline, yellow foreground (at least on debian)
:highlight StatusLineNC cterm=NONE " transparent background inactive statusline

:highlight TrailingWhitespace ctermbg=red
:match TrailingWhitespace /\s\+$/

:set viminfo=
:set noswapfile
:set splitright
:set history=0 " don't record commands
:set fillchars=stl:-,stlnc:- " use '-' for statusline filler
:set statusline=\ %f\ %=\ %l/%L\ 

" plug.vim as my plugin manager
:call plug#begin('~/.vim/plugins')

:Plug 'preservim/nerdtree' " :Explore replacement
:Plug 'kien/ctrlp.vim' " fuzzy find
:Plug 'bfrg/vim-cpp-modern' " modern cpp highlighting

:let g:cpp_function_highlight = 1
:let g:cpp_attributes_highlight = 1
:let g:cpp_member_highlight = 1
:let g:cpp_simple_highlight = 1

:call plug#end()
