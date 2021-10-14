FROM base:2.1 as base_image

ARG BUILD_ROOT="/home/build"
ARG SRC_DIR=${BUILD_ROOT}/src
ARG DEFAULT_SHELL="/bin/bash"

LABEL "name"="develop-image"
LABEL "distribution"="debian"
LABEL "description"="develop image for develop"
LABEL "version"="1.0"

ARG git_http_proxy=
ARG git_https_proxy=
ARG http_proxy=
ARG https_proxy=
ARG all_proxy=
ARG use_apt_mirror=


RUN export -n all_proxy http_proxy https_proxy && apt-get update && apt-get -y install make

# 构建组件依赖
RUN mkdir ${BUILD_ROOT}
COPY --chown=root:root src ${SRC_DIR}

# 设置DEBIAN_FRONTEND环境变量，apt-get执行模式为非交互式
#RUN env SHELL=${DEFAULT_SHELL} DEBIAN_FRONTEND=noninteractive git_http_proxy=${GIT_HTTP_PROXY} git_https_proxy=${GIT_HTTPS_PROXY} http_proxy=${HTTP_PROXY} https_proxy=${HTTPS_PROXY} all_proxy=${ALL_PROXY} use_apt_mirror=${USE_APT_MIRROR} make --trace -d -C ${SRC_DIR} all
RUN env SHELL=${DEFAULT_SHELL} DEBIAN_FRONTEND=noninteractive make -C ${SRC_DIR} all
