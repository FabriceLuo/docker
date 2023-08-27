#!/bin/bash

export PROXY_HOST=192.168.110.16
export PROXY_SOCKS_PORT=8094
export PROXY_HTTP_PORT=8095

case "$1" in
    set)
        . ./http_proxy.bash set
        . ./git_proxy.bash set
    ;;
    unset)
        . ./http_proxy.bash unset
        . ./git_proxy.bash unset
    ;;
    print)
        . ./http_proxy.bash print
        . ./git_proxy.bash print
    ;;
    *)
        echo "source|. ${0} set|unset|print"
    ;;
esac
