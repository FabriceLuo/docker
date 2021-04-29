#
# Makefile
# luominghao, 2021-04-29 12:06
#
#
OWNER=tmux
REPO=tmux

DOWNLOAD_ROOT ?= ./download
COMPILE_ROOT ?= ./compile

DOWNLOAD_NAME=tmux.tar.gz
DOWNLOAD_FILE=$(DOWNLOAD_ROOT)/$(DOWNLOAD_NAME)

COMPILE_NAME=tmux
COMPILE_DIR=$(COMPILE_ROOT)/$(COMPILE_NAME)

PREFIX_DIR=/opt/tmux

.PHONY: initialize dependence download decompress configure compile install all

initialize:
	git submodule init
	git submodule update

dependence:
	bash ./butterfly/shell/utils/apt-install-file.bash ./dependences.txt

download:
	mkdir -p $(DOWNLOAD_ROOT)
	bash ./butterfly/git/utils/download_github.bash latest_release $(OWNER) $(REPO) "$(DOWNLOAD_FILE)"

decompress:
	rm -rf $(COMPILE_DIR)
	mkdir -p $(COMPILE_DIR)
	tar -xzf $(DOWNLOAD_FILE) -C $(COMPILE_DIR) --strip-components 1

configure:
	cd $(COMPILE_DIR) && ./configure --prefix=$(PREFIX_DIR)

compile:
	cd $(COMPILE_DIR) && make

install:
	cd $(COMPILE_DIR) && make install
	install -D -m 0600 ./butterfly/tmux/tmux.conf ~/.tmux.conf

all: initialize dependence download decompress configure compile install
	@echo "Compile and install tmux successed."

# vim:ft=make
#
