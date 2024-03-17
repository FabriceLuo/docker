FROM base:2.2 as base_image

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
ARG make_target=

# 构建组件依赖
RUN mkdir ${BUILD_ROOT}
COPY --chown=root:root src ${SRC_DIR}

RUN mkdir /home/fabrice/.ssh
COPY --chmod=0600 --chown=fabrice:fabrice keys/ssh/id_rsa /home/fabrice/.ssh/id_rsa
COPY --chmod=0600 --chown=fabrice:fabrice keys/ssh/id_rsa.pub  /home/fabrice/.ssh/id_rsa.pub

# 设置DEBIAN_FRONTEND环境变量，apt-get执行模式为非交互式
RUN env SHELL=${DEFAULT_SHELL} DEBIAN_FRONTEND=noninteractive make -C ${SRC_DIR} ${make_target}
