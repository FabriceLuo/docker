#
# Makefile
# luominghao, 2020-07-19 04:30
#
image_version=1.0
image_name=develop

.PHONY: all build_docker

build_docker:
	@echo "begin to build docker image"
	docker build -t $(image_name):$(image_version) ./

all: build_docker

# vim:ft=make
