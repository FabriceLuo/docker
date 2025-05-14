#
# Makefile
# luominghao, 2020-07-19 04:30
#
IMAGE_NAME	=$(D_VIM_NAME)
IMAGE_VERSION	=$(D_VIM_VERSION)

.PHONY: all

all:
	docker build --no-cache \
		--build-arg HTTP_PROXY=$(HTTP_PROXY) \
		--build-arg HTTPS_PROXY=$(HTTPS_PROXY) \
		--build-arg ALL_PROXY=$(ALL_PROXY) \
		--build-arg D_DEVELOP_NAME=$(D_DEVELOP_NAME) \
		--build-arg D_DEVELOP_VERSION=$(D_DEVELOP_VERSION) \
		-t $(IMAGE_NAME):$(IMAGE_VERSION) ./

# vim:ft=make
#
