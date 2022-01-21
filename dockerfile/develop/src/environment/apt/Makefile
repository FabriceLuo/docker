#
# Makefile
# fabriceluo, 2021-10-12 23:37
#

all:
	@echo "prepare apt source list file"
	test -n $$use_apt_mirror && cp -f /etc/apt/sources.list /etc/apt/sources.list.back && cp -f $$use_apt_mirror /etc/apt/sources.list
	@echo "prepare git proxy"
	test -n $$git_http_proxy && echo "[http]\n    proxy=$${git_http_proxy}" >> ~/.gitconfig
	test -n $$git_https_proxy && echo "[https]\n    proxy=$${git_http_proxy}" >> ~/.gitconfig


# vim:ft=make
#
