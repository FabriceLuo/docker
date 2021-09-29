#
# Makefile
# luominghao, 2020-07-19 04:30
#
image_version=1.0
image_name=nextcloud-image

.PHONY: build

build:
	@echo "begin docker build"
	docker build -t $(image_name):$(image_version) ./
	@echo "end docker build"

# vim:ft=make
#
