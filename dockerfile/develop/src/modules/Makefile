#
# Makefile
# luominghao, 2020-09-02 08:23
#

SUBDIRS = base tmux ctags golang cmake bash git autossh pet
DEBUGDIRS = base
#SUBDIRS = base python3 pre-commit
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
