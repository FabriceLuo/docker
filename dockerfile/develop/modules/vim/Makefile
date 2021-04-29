#
# Makefile
# luominghao, 2020-09-02 08:23
#
#
GITHUB_URL=https://github.com/FabriceLuo/vim.git
CLONE_DES_DIR=./vim

.PHONY: clone make all

clone:
	@echo "clone vim github."
	git clone -b main $(GITHUB_URL) $(CLONE_DES_DIR)

make:
	@echo "compile and install vim."
	cd $(CLONE_DES_DIR) && make all

all: clone make
	@echo "build vim from github."

# vim:ft=make
#
