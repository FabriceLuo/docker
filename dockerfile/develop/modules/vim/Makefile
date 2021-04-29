#
# Makefile
# FabriceLuo, 2021-04-28 16:01
#
#

OWNER     = vim
REPO      = vim
REPO_TYPE = latest_tag

CONFIGURE_PARAMS=--enable-python3interp=yes --enable-cscope --enable-terminal --enable-multibyte --enable-gui=no

include ../butterfly/makefile/make-install.mk

finish:
	install -D -m 0600 vimrc ~/.vimrc
	cd $(COMPILE_DIR) && ./src/vim --version

# vim:ft=make
#
