#
# Makefile
# luominghao, 2020-07-19 04:30
#
IMAGE_NAME	=$(D_BASE_NAME)
IMAGE_VERSION	=$(D_BASE_VERSION)

.PHONY: all

all:
	rm -rf ./ssh
	cp -rf ~/.ssh ./ssh
	docker build --no-cache -t $(IMAGE_NAME):$(IMAGE_VERSION) ./

# vim:ft=make
#
