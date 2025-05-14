#! /bin/bash
#
# apt-install-file.bash
# Copyright (C) 2020 luominghao <luominghao@live.com>
#
# Distributed under terms of the MIT license.
#

DEPENDENCE_FILE=$1

if [[ -z $DEPENDENCE_FILE ]]; then
    echo "apt dependence file is not specifiled"
    exit 1
fi

if [[ ! -f "${DEPENDENCE_FILE}" ]]; then
    echo "apt dependence file(${DEPENDENCE_FILE}) is not found"
    exit 2
fi

export -n all_proxy http_proxy https_proxy
export DEBIAN_FRONTEND=noninteractive
# 先更新下缓存
apt-get update

dependences=""
for dependence in $(cat "${DEPENDENCE_FILE}" | grep -v -E "^\s*#|^\s*$")
do
    dependences="${dependences} ${dependence}"
done

if [[ -z "${dependences}" ]]; then
    echo "no dependence found in ${DEPENDENCE_FILE}"
    exit 0
fi

# 安装依赖
echo "install dependence: ${dependences}"
# 这里使用--no-install-recommends，避免安装不必要的依赖
apt-get -y install --no-install-recommends ${dependences}
if [[ $? -ne 0 ]]; then
    echo "install dependence(${dependences}) failed"
    exit 3
fi

# 清理缓存
apt-get clean
apt-get autoclean
apt-get autoremove -y
# 删除多余的文件
rm -rf /var/lib/apt/lists/*
rm -rf /var/cache/apt/archives/*.deb
rm -rf /var/cache/apt/archives/lock
rm -rf /var/lib/dpkg/lock
rm -rf /var/lib/dpkg/lock-frontend
rm -rf /var/lib/dpkg/lock-old
rm -rf /var/cache/debconf/*.dat
rm -rf /var/cache/debconf/*.dat-old
rm -rf /var/cache/debconf/*.bak
rm -rf /var/cache/debconf/*.bak-old
rm -rf /var/cache/debconf/*.old
rm -rf /var/cache/debconf/*.old-old
rm -rf /var/cache/debconf/*.tmp

exit 0
