#
# Makefile
# luominghao, 2020-09-02 08:23
#

SUBDIRS = base tmux vim 
BUTTERFLY_URL ?= https://github.com/FabriceLuo/butterfly.git
export BUTTERFLY_DIR = $(realpath ./butterfly)

.PHONY: butterfly $(SUBDIRS)

butterfly:
	git clone $(BUTTERFLY_URL)

$(SUBDIRS):
	@echo "build $@"
	$(MAKE) -C $@ all

all: butterfly $(SUBDIRS)
# vim:ft=make
#
