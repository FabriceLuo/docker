#
# Makefile
# fabriceluo, 2021-10-12 23:46
#
SUBDIRS = environment modules

.PHONY: environment modules all

$(SUBDIRS):
	@echo "build $@"
	$(MAKE) -C $@ all

all: $(SUBDIRS)
# vim:ft=make
#
