#
# Makefile
# luominghao, 2020-09-02 08:23
#

SUBDIRS = base tmux ctags golang cmake bash git autossh pet bat delta fd nvim oh-my-zsh powerlevel10k ripgrep tmux-tpm yq zsh-autosuggestions zsh-syntax-highlighting
DEBUGDIRS = base
export DEVELOP_USER = fabrice

.PHONY: $(SUBDIRS) debug

$(SUBDIRS):
	@echo "build $@"
	$(MAKE) -C $@ all

debug: $(DEBUGDIRS)
	@echo "make debug!"


all: $(SUBDIRS)
# vim:ft=make
#
