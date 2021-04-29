FROM base:2.0 as base_image

ARG pkg_install="apt-get -y install"

ENV DEBIAN_FRONTEND noninteractive

LABEL "name"="fish-image"
LABEL "distribution"="debian10"
LABEL "description"="common base image for running app"
LABEL "version"="1.0"

USER root:root
SHELL ["/bin/bash", "-c"]

ENTRYPOINT ["/usr/bin/env", "LANG=en_US.UTF-8"]

# 配置默认的启动命令
CMD ["/bin/bash", "-i"]

RUN apt-get update

# 安装vim
RUN ${pkg_install} vim
