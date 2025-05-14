#
# Makefile
# fabriceluo, 2025/04/17
#
#

CLONE_URL = git@github.com:FabriceLuo/keys.git

CLONE_DST_ROOT = ./download
CLONE_DST_NAME = keys

include $(MAKEFILE_DIR)/git-clone.mk

configure:
	@rm -rf /home/$(DEVELOP_USER)/.ssh
	@cp -rf $(CLONE_DST_ROOT)/$(CLONE_DST_NAME)/ssh /home/$(DEVELOP_USER)/.ssh

# vim:ft=make
