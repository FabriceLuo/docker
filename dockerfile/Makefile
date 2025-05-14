export D_BASE_NAME		= base
export D_BASE_VERSION		= 1.1

export D_DEVELOP_NAME		= develop
export D_DEVELOP_VERSION	= 1.6

export D_VIM_NAME		= vim
export D_VIM_VERSION		= 5.0

export DEVELOP_USER 		= fabrice
export PATHRC 			= /home/$(DEVELOP_USER)/.pathrc

export http_proxy=

# 构建时代理相关的环境变量
SOCKS5_PROXY=socks5://172.17.0.1:8094

export HTTP_PROXY	=http://172.17.0.1:8095
export HTTPS_PROXY	=http://172.17.0.1:8095
export ALL_PROXY	=$(SOCKS5_PROXY)

.PHONY: all base develop vim

all: base develop vim

base:
	$(MAKE) -C ./base

develop:
	$(MAKE) -C ./develop


vim:
	$(MAKE) -C ./vim
