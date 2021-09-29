#! /bin/bash
#
# gen_md5sum.bash 为目录中的文件生成md5摘要信息
# Copyright (C) 2021 fabriceluo <fabriceluo@outlook.com>
#
# Distributed under terms of the MIT license.
#

if [[ $# -lt 2 ]]; then
    echo "params error. $0 files-dir md5sum-file"
    exit 1
fi

file_dir=$1
md5sum_file=$2

if [[ ! -d "${file_dir}" ]]; then
    echo "files dir(${file_dir}) not found."
    exit 2
fi

if [[ -f "${md5sum_file}" ]]; then
    echo "md5sum file(${md5sum_file}) is exists."
    exit 2
fi

if find "${file_dir}" -type f | xargs -i md5sum {} > "${md5sum_file}";then
    echo "md5sum dir(${file_dir}) files into ${md5sum_file} success."
else
    echo "md5sum dir(${file_dir}) files into ${md5sum_file} failed."
fi
