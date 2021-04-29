#
# Makefile
# luominghao, 2020-09-05 02:12
#
#

subdirs = docker dockerd base develop

$(subdirs):
	$(MAKE) -C $@ all

.PHONY: $(subdirs)

all: $(subdirs)
	@echo "install docker config to system success"


# vim:ft=make
#
