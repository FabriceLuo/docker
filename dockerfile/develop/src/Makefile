#
# Makefile
# fabriceluo, 2021-10-12 23:46
#

SUBDIRS = modules
BUTTERFLY_URL ?= https://github.com/FabriceLuo/butterfly.git

.PHONY: butterfly environment modules all

export BUTTERFLY_DIR = $(realpath ./)/butterfly
export DEVELOP_USER = fabrice
export PATHRC = /home/$(DEVELOP_USER)/.pathrc

prepare:
	touch $(PATHRC)
	git clone $(BUTTERFLY_URL)

$(SUBDIRS):
	@echo "build $@"
	$(MAKE) -C $@ $(MAKECMDGOALS)

all debug: prepare $(SUBDIRS)
# vim:ft=make
#
