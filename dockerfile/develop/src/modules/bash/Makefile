#
# Makefile
# fabriceluo, 2021-10-10 21:19
#

DEVELOP_USER ?= fabrice

all:
	su -c 'install -D -m 0700 proxy.bash ~/.proxy.bash' $(DEVELOP_USER)
	su -c 'cat ./bashrc.bash >> ~/.bashrc' $(DEVELOP_USER)

# vim:ft=make
#
