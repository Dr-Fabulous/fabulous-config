.POSIX:
.PHONY: install uninstall

# vars
PRINTF_ERROR=printf "\033[1;31mERROR\033[0m: %s\n"
PRINTF_WARNING=printf "\033[1;33mWARNING\033[0m: %s\n"
INSTALL_STAMP=.install-stamp
FZF_HASH=master
FZF_COMPLETION_URL=https://raw.githubusercontent.com/junegunn/fzf/$(FZF_HASH)/shell/completion.bash
FZF_BINDINGS_URL=https://raw.githubusercontent.com/junegunn/fzf/$(FZF_HASH)/shell/key-bindings.bash
GIT_PROMPT_HASH=master
GIT_PROMPT_URL=https://raw.githubusercontent.com/git/git/$(GIT_PROMPT_HASH)/contrib/completion/git-prompt.sh
FABULOUS_ROOT=$(PWD)

# exports
export FABULOUS_ROOT

# commands
DEP=command -V --
CP=cp --interactive --
RM=rm --
LN=ln --symbolic --interactive --
GIT=git
FIND=find
MKDIR=mkdir -p --
CHMOD=chmod
TOUCH=touch --
CURL=curl --
ENVSUBST=envsubst '$$FABULOUS_ROOT'

install: shell/install vim/install tmux/install gpg/install
uninstall: shell/uninstall vim/uninstall tmux/uninstall gpg/uninstall

.PHONY: shell/install shell/uninstall
shell/install:
	@! [ -f "shell/$(INSTALL_STAMP)" ] || { $(PRINTF_ERROR) "shell installation already present" 1>&2 && false; }
	$(ENVSUBST) 0<"shell/templates/profile.template" 1>"$(HOME)/.profile"
	$(ENVSUBST) 0<"shell/templates/rc.template" 1>"$(HOME)/.shellrc"
	$(CP) "$(HOME)/.shellrc" "$(HOME)/.bashrc"
	$(CP) "shell/inputrc" "$(HOME)/.inputrc"
	$(ENVSUBST) 0<"shell/templates/fabulous-shellrc.template" 1>"shell/rc.d/0-fabulous-shellrc"
	$(CURL) $(FZF_COMPLETION_URL) 1>"shell/rc.d/1-fzf-completion.bash"
	$(CURL) $(FZF_BINDINGS_URL) 1>"shell/rc.d/2-fzf-bindings.bash"
	$(CURL) $(GIT_PROMPT_URL) 1>"shell/git-prompt.sh"
	$(CHMOD) o+x -- "shell/git-prompt.sh"
	$(TOUCH) "shell/$(INSTALL_STAMP)"

shell/uninstall:
	@[ -f "shell/$(INSTALL_STAMP)" ] || { $(PRINTF_ERROR) "shell installation not present" 1>&2 && false; }
	-$(RM) "$(HOME)/.profile"
	-$(RM) "$(HOME)/.shellrc"
	-$(RM) "$(HOME)/.bashrc"
	-$(RM) "shell/rc.d/0-fabulous-shellrc"
	-$(RM) "shell/rc.d/1-fzf-completion.bash"
	-$(RM) "shell/rc.d/2-fzf-bindings.bash"
	$(RM) "shell/$(INSTALL_STAMP)"

.PHONY: vim/install vim/uninstall
vim/install:
	@! [ -f "vim/$(INSTALL_STAMP)" ] || { $(PRINTF_ERROR) "vim installation already present" 1>&2 && false; }
	$(MKDIR) "$(HOME)/.vim"
	$(MKDIR) "$(HOME)/.config/nvim"
	$(LN) "$(PWD)/vim/init.vim" "$(HOME)/.vimrc"
	$(LN) "$(PWD)/vim/init.vim" "$(HOME)/.config/nvim"
	$(LN) "$(PWD)/vim/pack" "$(HOME)/.vim"
	$(LN) "$(PWD)/vim/pack" "$(HOME)/.config/nvim"
	$(GIT) submodule update --init --recursive --depth=1
	$(FIND) "vim/pack/upstream/opt" -type d -a -name doc -exec vim -es -c ":helptags {}" \;
	$(TOUCH) "vim/$(INSTALL_STAMP)"

vim/uninstall:
	@[ -f "vim/$(INSTALL_STAMP)" ] || { $(PRINTF_ERROR) "vim installation not present" 1>&2 && false; }
	-$(RM) "$(HOME)/.vimrc"
	-$(RM) "$(HOME)/.config/nvim/init.vim"
	-$(RM) "$(HOME)/.vim/pack"
	-$(RM) "$(HOME)/.config/nvim/pack"
	-$(GIT) submodule deinit --all
	$(RM) "vim/$(INSTALL_STAMP)"

.PHONY: tmux/install tmux/uninstall
tmux/install:
	@! [ -f "tmux/$(INSTALL_STAMP)" ] || { $(PRINTF_ERROR) "tmux installation already present" 1>&2 && false; }
	$(ENVSUBST) 0<"tmux/tmux.conf.template" 1>"$(HOME)/.tmux.conf"
	$(TOUCH) "tmux/$(INSTALL_STAMP)"

tmux/uninstall:
	@[ -f "tmux/$(INSTALL_STAMP)" ] || { $(PRINTF_ERROR) "tmux installation not present" 1>&2 && false; }
	-$(RM) "$(HOME)/.tmux.conf"
	$(RM) "tmux/$(INSTALL_STAMP)"

.PHONY: gpg/install gpg/uninstall
gpg/install:
	@! [ -f "gpg/$(INSTALL_STAMP)" ] || { $(PRINTF_ERROR) "gpg installation already present" 1>&2 && false; }
	$(MKDIR) "$(HOME)/.ssh"
	$(MKDIR) "$(HOME)/.gnupg"
	$(ENVSUBST) 0<"gpg/ssh-config.template" 1>"$(HOME)/.ssh/config"
	$(LN) "$(PWD)/gpg/gpg-agent.conf" "$(HOME)/.gnupg/gpg-agent.conf"
	$(TOUCH) "$(HOME)/.gnupg/sshcontrol"
	$(TOUCH) "gpg/$(INSTALL_STAMP)"
	@$(PRINTF_WARNING) "make sure to put your auth keygrips into $(HOME)/.gnupg/sshcontrol"

gpg/uninstall:
	@[ -f "gpg/$(INSTALL_STAMP)" ] || { $(PRINTF_ERROR) "gpg installation not present" 1>&2 && false; }
	-$(RM) "$(HOME)/.ssh/config"
	-$(RM) "$(HOME)/.gnupg/gpg-agent.conf"
	$(RM) "gpg/$(INSTALL_STAMP)"
