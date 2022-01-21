#
# Makefile
# luominghao, 2020-09-02 08:23
#

#SUBDIRS = base tmux vim ctags golang cmake bash git autossh
SUBDIRS = base python3 pre-commit
#SUBDIRS = base
export DEVELOP_USER = fabrice

.PHONY: $(SUBDIRS)

$(SUBDIRS):
	@echo "build $@"
	$(MAKE) -C $@ all

all: $(SUBDIRS)
# vim:ft=make
#
