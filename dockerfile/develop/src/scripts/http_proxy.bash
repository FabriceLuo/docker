#!/bin/bash

# http.proxy
# https.proxy
if [[ -z $PROXY_HOST ]]; then
    PROXY_HOST="127.0.0.1"
fi

if [[ -z $PROXY_HTTP_PORT ]]; then
    PROXY_HTTP_PORT="8095"
fi

case "$1" in
    set)
        export http_proxy="socks5://${PROXY_HOST}:${PROXY_HTTP_PORT}"
        export https_proxy="socks5://${PROXY_HOST}:${PROXY_HTTP_PORT}"
        # export all_proxy="socks5://${PROXY_HOST}:${PROXY_HTTP_PORT}"
    ;;
    unset)
        unset http_proxy
        unset https_proxy
        # unset all_proxy
    ;;
    print)
        echo "http_proxy:${http_proxy}"
        echo "https_proxy:${https_proxy}"
        # echo "all_proxy:${all_proxy}"
    ;;
    *)
        echo "source|. ${0} set|unset|print"
    ;;
esac
