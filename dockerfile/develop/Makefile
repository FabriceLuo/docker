#
# Makefile
# luominghao, 2020-07-19 04:30
#
image_version=3.7
image_name=develop-with-nvim

# 构建时代理相关的环境变量
socks5_proxy=socks5://172.17.0.1:8094

git_http_proxy=$(socks5_proxy)
git_https_proxy=$(socks5_proxy)
# for shell proxy
http_proxy=http://172.17.0.1:8095
https_proxy=http://172.17.0.1:8095
all_proxy=$(socks5_proxy)

.PHONY: debug no_proxy all

all debug:
	@rm -rf keys
	@git clone git@github.com:FabriceLuo/keys.git

	@echo "begin to build docker image on all proxy"
	@DOCKER_BUILDKIT=1 docker build --no-cache \
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
