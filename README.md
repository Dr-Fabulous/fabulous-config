# fabulous-config
my personal configuration for my most used software

## vim
### what's included?
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
- new mappings for easily invoking makefiles
- new mappings for quickly reusing shell commands

### install
This configuration depends on [fzf](https://github.com/junegunn/fzf), [ripgrep](https://github.com/BurntSushi/ripgrep) and [batcat](https://github.com/sharkdp/bat).
Make sure these are installed before proceeding.

Firstly pull upstream plugins with `git submodule update --init --recursive --depth=1`,
this will clone each of the submodules to their latest version but will only download the
latest commit.

All that's left is to make symbolic links to `init.vim` and `pack` depending on which
editor you are using.

#### vim
`~/.vimrc` -> `fabulous-config/init.vim`

`~/.vim/pack` -> `fabulous-config/pack`

#### neovim
`~/.config/nvim/init.vim` -> `fabulous-config/init.vim`

`~/.config/nvim/pack` -> `fabulous-config/pack`

## gpg-config
### what's included?
- Minimal configuration nessecary to use gpg keys as a drop in replacement for ssh keys (I like to manage my keys in one place).

### install
This setup relies on using gpg-agent instead of the regular ssh-agent. This also requires having gpg-agent
started automatically whenever ssh is used

First source gpgrc in whichever .shellrc you use, this will set the nessecary enviroment
variables that gpg-agent needs.
`. "fabulous-config/gpg/gpgrc"

Secondly copy or symbolically link `fabulous-config/gpg/gnupg` to `~/.gnupg` and add the keygrip of auth
subkeys you want to use for ssh into `~/.gnupg/sshcontrol`. This will be the list of public keys
that will be offered when you make an ssh connection.

Lastly link `fabulous-config/gpg/ssh` to `~/.ssh` to have ssh automatically start gpg-agent.

## tmux
### what's included?
- Better prefix (C-Space)
- Mappings to navigate between planes (C-h/j/k/l)
- Mappings to resize planes (A-h/j/k/l)
- Mappings to open splits (C-h/C-v)
- Integration with fzf to select between sessions & open new projects
- Ability to close sessions without terminating the client (C-X)

### install
This configuration depends on [fzf](https://github.com/junegunn/fzf). Make sure these are installed before
proceeding.


All that needs to be done is to link `fabulous-config/tmux/tmux.conf` to `~/.tmux.conf` and
`fabulous-config/tmux/scripts` to `~/.tmux`.
