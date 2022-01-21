#
# Makefile
# fabriceluo, 2022-01-20 16:25
#
#
PYPI_CONF_DIR ?= ~/.pip
PYPI_CONF_FILE ?= $(PYPI_CONF_DIR)/pip.conf

DEVELOP_USER ?= fabrice

all:
	@echo "prepare pypi mirror file"
	mkdir -p $(PYPI_CONF_DIR) && install -D -m 0600 pip.conf $(PYPI_CONF_FILE)
	su -c 'mkdir -p $(PYPI_CONF_DIR) && install -D -m 0600 pip.conf $(PYPI_CONF_FILE)' $(DEVELOP_USER)

# vim:ft=make
#
