#
# Makefile
# FabriceLuo, 2021-04-28 16:01
#
#
include ../../common/develop-debug.mk

REPO      = tpm
DOWNLOAD_URL = https://github.com/tmux-plugins/tpm/archive/refs/tags/v3.1.0.tar.gz

TAR_STRIP_COMPONENTS = 1

TMUX_CONFIG_ROOT = /home/$(PATH_USER)/.tmux
INSTALL_ROOT = $(TMUX_CONFIG_ROOT)/plugins/tpm

include $(BUTTERFLY_DIR)/makefile/download-install.mk

install:
	mkdir -p "$(INSTALL_ROOT)"
	tar -xf "$(DOWNLOAD_FILE)" --strip-components $(TAR_STRIP_COMPONENTS) -C "$(INSTALL_ROOT)"
	chown -R fabrice:fabrice $(TMUX_CONFIG_ROOT)

# vim:ft=make
#
