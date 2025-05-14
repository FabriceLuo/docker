.PHONY: all

export MAKEFILE_DIR=/home/build/src/butterfly/makefile
export BUTTERFLY_DIR=/home/build/src/butterfly
export DEVELOP_USER 	= fabrice
export PATHRC 		= /home/$(DEVELOP_USER)/.pathrc

ifeq ($(VIM), vim)
	VIM_DIR=vim
else
	VIM_DIR=nvim
endif

all:
	@$(MAKE) -s -C nvim all
