#
# Makefile
# luominghao, 2020-09-02 08:32
#
.PHONY: initialize all

initialize:
	git submodule init
	git submodule update

install:
	bash ./butterfly/shell/utils/apt-install-file.bash ./dependences.txt

all: initialize install
	@echo "build essentials."

# vim:ft=make
#
