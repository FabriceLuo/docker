#
# Makefile
# luominghao, 2020-09-02 08:23
#

SUBDIRS = base tmux vim ctags golang cmake
BUTTERFLY_URL ?= https://github.com/FabriceLuo/butterfly.git
export BUTTERFLY_DIR = $(realpath ./butterfly)
export DEVELOP_USER = fabrice

.PHONY: butterfly $(SUBDIRS)

butterfly:
	git clone $(BUTTERFLY_URL)

$(SUBDIRS):
	@echo "build $@"
	$(MAKE) -C $@ all

clean:
	rm -rf ./butterfly

all: butterfly $(SUBDIRS)
# vim:ft=make
#
