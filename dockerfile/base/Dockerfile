FROM debian:12

ARG pkg_install="apt-get -y install"

ENV DEBIAN_FRONTEND=noninteractive

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
RUN sed -i 's/deb.debian.org/mirrors.ustc.edu.cn/g' /etc/apt/sources.list.d/debian.sources
RUN apt-get update

RUN ${pkg_install} --no-install-recommends \
    apt-utils \
    less \
    dialog \
    locales \
    git \
    make \
    curl \
    build-essential \
    procps \
    python3 \
    python3-pip \
    python3-dev \
    python3-venv \
    jq \
    yq \
    autoconf \
    automake \
    pkg-config \
    bc \
    cloc \
    ethtool \
    netcat-openbsd \
    sshpass \
    strace \
    ltrace \
    tree \
    unzip \
    uuid \
    man \
    zsh \
    iputils-ping \
    tcpdump \
    iproute2 \
    yacc \
    yadm \
    perltidy \
    luarocks \
    libtree-sitter-dev \
    nodejs \
    npm \
    rsync \
    sshpass \
    ssh

# 配置locales为en_US.UTF-8
RUN localedef -i en_US -f UTF-8 en_US.UTF-8

RUN useradd -m -U -s /bin/bash fabrice
RUN echo -e "081126\n081126" | passwd root
RUN echo -e "081126\n081126" | passwd fabrice
COPY --chown=fabrice:fabrice ssh /home/fabrice/.ssh
RUN chmod 600 -R /home/fabrice/.ssh/*
