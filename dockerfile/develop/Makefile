#
# Makefile
# luominghao, 2020-07-19 04:30
#
image_version=2.0
image_name=develop

# 构建时代理相关的环境变量
socks5_proxy=socks5://192.168.2.1:8094
git_http_proxy=$(socks5_proxy)
git_https_proxy=$(socks5_proxy)
http_proxy=$(socks5_proxy)
https_proxy=$(socks5_proxy)
all_proxy=$(socks5_proxy)
use_apt_mirror=/home/build/src/environment/sources.list

.PHONY: all_proxy no_proxy all

all_proxy:
	@echo "begin to build docker image on all proxy"
	docker build --no-cache \
		--build-arg git_http_proxy=$(git_http_proxy) \
		--build-arg git_https_proxy=$(git_https_proxy) \
		--build-arg http_proxy=$(http_proxy) \
		--build-arg https_proxy=$(https_proxy) \
		--build-arg all_proxy=$(all_proxy) \
		--build-arg use_apt_mirror=$(use_apt_mirror) \
		-t $(image_name):$(image_version) ./

no_proxy:
	@echo "begin to build docker image on no proxy"
	docker build -t $(image_name):$(image_version) ./

all: all_proxy

# vim:ft=make
