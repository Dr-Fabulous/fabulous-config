# fabulous-config
my personal configuration for my most used software

## what's included?
### shell
- A new profile.d/rc.d directories for multiple login/shell startup files

### vim
- support for both vim and neovim
- minimalist styling
- reduced disk usage
- fuzzy finding on builtin commands like :find
- in neovim opening editors in terminal buffers opens a new split
- fzf.vim, fugitive.vim as well as custom fuzzy finders to change directory and a real time grep
- mappings to more easily switch between buffers, location list, quickfix list and tags
- mapping to reload the rc file.

### tmux
- ctrl-space prefix
- (v)ertical and (h)orizontal split mappings
- navigate panes with ctrl-[hjkl]
- resize panes with alt-[hjkl]
- mapping to kill sessions without ending the session
- mapping to fuzzy find projects and start new sessions
- mapping to fuzzy find existing sessions
- minimal status line

### gpg
- minimal config to use gpg-agent in place of ssh-agent
- ssh commands will automatically start gpg-agent
- ssh-config.d

## install
This configuration depends on [fzf](https://github.com/junegunn/fzf), [ripgrep](https://github.com/BurntSushi/ripgrep), [fd](https://github.com/sharkdp/fd) and [batcat](https://github.com/sharkdp/bat).
Make sure these are installed before proceeding.

Then either run `make install` or `make <component>/install` to get some of the config working.

If you are using the gpg configuration, make sure to put your gpg authentication keygrips in `~/.gnupg/sshcontrol`
