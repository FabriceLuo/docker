#
# Makefile
# fabriceluo, 2021-10-12 23:46
#

BUTTERFLY_URL ?= https://github.com/FabriceLuo/butterfly.git

.PHONY: butterfly 3rd all

export BUTTERFLY_DIR 	= $(realpath ./)/butterfly
export DEVELOP_USER 	= fabrice
export PATHRC 		= /home/$(DEVELOP_USER)/.pathrc
export MAKEFILE_DIR	= $(BUTTERFLY_DIR)/makefile

environment:
	@touch $(PATHRC)
	@git clone $(BUTTERFLY_URL)

3rd:
	@$(MAKE) -C ./3rd $(MAKECMDGOALS)

all: environment 3rd
# vim:ft=make
#
