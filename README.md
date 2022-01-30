# vim-config
my personal configuration for vim/neovim

## what's included?
- A more minimalistic appearance with bars/dashes seperating windows
- Color selections for things like vim popup menus that don't hurt your eyes (seriously why is pink a default)
- Disabled viminfo & swapfiles to reduce writing to disk.
- Omni-completion is now turned on
- Additional include paths for C/C++ header files (see :help gf)
- Useless trailing whitespace is now highlighted
- different tab configurations for different file types (pack/custom/opt/auto-tab)
- automatic syntax regions for languages within other languages e.g. js or css in html (pack/cusotm/opt/region)
- new mappings for quickly building and running projects
- new mappings for navigating quickfix lists, location lists and buffers.
- new mappings for fuzzy finding files, ctags, fast grep (ripgrep), commits, open buffers and :help tags

## install
This configuration depends on [fzf](https://github.com/junegunn/fzf), [ripgrep](https://github.com/BurntSushi/ripgrep) and [batcat](https://github.com/sharkdp/bat).
Make sure these are installed before proceeding.

Firstly pull upstream plugins with `git submodule update --init --recursive --depth=1`,
this will clone each of the submodules to their latest version but will only download the
latest commit.

All that's left is to make symbolic links to `init.vim` and `pack` depending on which
editor you are using.

### vim
`~/.vimrc` -> `vim-config/init.vim`

`~/.vim/pack` -> `vim-config/pack`

### neovim
`~/.config/nvim/init.vim` -> `vim-config/init.vim`

`~/.config/nvim/pack` -> `vim-config/pack`
