FROM debian:11 as base_image

ARG pkg_install="apt-get -y install"

ENV DEBIAN_FRONTEND noninteractive

LABEL "name"="base-image"
LABEL "distribution"="debian11"
LABEL "description"="common base image for develop"
LABEL "version"="2.2"

USER root:root
SHELL ["/bin/bash", "-c"]

ENTRYPOINT ["/usr/bin/env", "LANG=en_US.UTF-8"]

# 配置默认的启动命令
CMD ["/bin/bash", "-i"]

# 使用优化后的apt源配置，加速安装速度
COPY --chown=root:root ["sources.list", "/etc/apt/sources.list"]
RUN apt-get update

RUN ${pkg_install} apt-utils

# 配置locales为en_US.UTF-8
RUN ${pkg_install} yacc dialog locales build-essential git procps make curl python3 python3-pip python3-dev jq yq autoconf automake pkg-config bc cloc ethtool netcat-openbsd sshpass strace ltrace tree unzip uuid man zsh iputils-ping tcpdump iproute2 yadm libjansson-dev

RUN localedef -i en_US -f UTF-8 en_US.UTF-8

RUN useradd -m -U -s /bin/bash fabrice
RUN echo -e "081126\n081126" | passwd root
RUN echo -e "081126\n081126" | passwd fabrice
