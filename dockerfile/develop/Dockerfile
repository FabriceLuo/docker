FROM base:2.0 as base_image

ENV dependence_build="/home/build"
ENV build_modules=${dependence_build}/modules
ENV default_shell="/bin/bash"

ENV DEBIAN_FRONTEND noninteractive

LABEL "name"="develop-image"
LABEL "distribution"="debian"
LABEL "description"="develop image for develop"
LABEL "version"="1.0"


RUN apt-get update
RUN apt-get -y install make

# 构建组件依赖
RUN mkdir ${dependence_build}
COPY --chown=root:root modules ${build_modules}
RUN env SHELL=${default_shell} make -C ${build_modules}
