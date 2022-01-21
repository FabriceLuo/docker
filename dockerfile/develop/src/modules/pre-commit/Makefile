#
# Makefile
# fabriceluo, 2022-01-19 15:26
#

REPO         ?= pre-commit
DEVELOP_USER ?= fabrice

include $(BUTTERFLY_DIR)/makefile/pypi-install.mk

finish:
	@su -c 'git config --global init.templateDir ~/.git-template' $(DEVELOP_USER)
	@su -c 'install -D -m 0600 ./pre-commit-config.yaml ~/.pre-commit-config.yaml' $(DEVELOP_USER)
	@su -c 'pre-commit init-templatedir -c ~/.pre-commit-config.yaml  ~/.git-template' $(DEVELOP_USER)

# vim:ft=make
#
