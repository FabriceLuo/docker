#! /bin/bash
#
# ycm-install.bash
# Copyright (C) 2021 fabriceluo <fabriceluo@outlook.com>
#
# Distributed under terms of the MIT license.
#

old_pwd=$(pwd)
ycm_dir=~/.vim/plugged/YouCompleteMe

cd "${ycm_dir}"

python3 install.py --go-completer
code=$?

cd "${old_pwd}"
exit $code
