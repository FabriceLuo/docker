#
# Makefile
# luominghao, 2020-09-02 08:23
#

SUBDIRS = base vim tmux
BUTTERFLY_URL ?= https://github.com/FabriceLuo/butterfly.git

.PHONY: butterfly $(SUBDIRS)

butterfly:
	git clone $(BUTTERFLY_URL)

$(subdirs):
	@echo "build $@"
	$(MAKE) -C $@ all

all: butterfly $(subdirs)
# vim:ft=make
#
