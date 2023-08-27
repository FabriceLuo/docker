#
# Makefile
# luominghao, 2020-07-19 04:30
#
image_version=3.5
image_name=develop-with-vim

# 构建时代理相关的环境变量
socks5_proxy=socks5://192.168.110.16:8094
# for git proxy
git_http_proxy=$(socks5_proxy)
git_https_proxy=$(socks5_proxy)
# for shell proxy
http_proxy=$(socks5_proxy)
https_proxy=$(socks5_proxy)
all_proxy=$(socks5_proxy)


.PHONY: debug no_proxy all

all debug:
	@echo "begin to build docker image on all proxy"
	docker build --no-cache \
		--build-arg git_http_proxy=$(git_http_proxy) \
		--build-arg git_https_proxy=$(git_https_proxy) \
		--build-arg http_proxy=$(http_proxy) \
		--build-arg https_proxy=$(https_proxy) \
		--build-arg all_proxy=$(all_proxy) \
		--build-arg make_target=$(MAKECMDGOALS) \
		-t $(image_name):$(image_version) ./

no_proxy:
	@echo "begin to build docker image on $@"
	docker build --build-arg make_target=$(MAKECMDGOALS) -t $(image_name):$(image_version) ./

# vim:ft=make
