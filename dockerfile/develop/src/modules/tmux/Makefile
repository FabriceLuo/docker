#
# Makefile
# luominghao, 2021-04-29 12:06
#
#
OWNER     = tmux
REPO      = tmux
REPO_TYPE = latest_release

DEVELOP_USER ?= fabrice

include ../butterfly/makefile/make-install.mk

finish:
	su -c 'install -D -m 0600 ../butterfly/tmux/tmux.conf ~/.tmux.conf' $(DEVELOP_USER)

# vim:ft=make
#
