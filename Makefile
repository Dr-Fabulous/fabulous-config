.POSIX:
.PHONY: install uninstall

# vars
PRINTF_ERROR=printf "\033[1;31mERROR\033[0m: %s\n"
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
CP=cp --
RM=rm --
CHMOD=chmod
TOUCH=touch --
CURL=curl --
ENVSUBST=envsubst '$$FABULOUS_ROOT'

install: shell/install

uninstall: shell/uninstall

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
	-$(RM) "shell/rc.d/0-fabulous-shell"
	-$(RM) "shell/rc.d/1-fzf-completion.bash"
	-$(RM) "shell/rc.d/2-fzf-bindings.bash"
	$(RM) "shell/$(INSTALL_STAMP)"
