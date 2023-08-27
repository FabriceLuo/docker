#!/bin/bash

# http.proxy
# https.proxy
if [[ -z $PROXY_HOST ]]; then
    PROXY_HOST="127.0.0.1"
fi

if [[ -z $PROXY_SOCKS_PORT ]]; then
    PROXY_SOCKS_PORT="8094"
fi

case "$1" in
    set)
        git config --global --add http.proxy "socks5://${PROXY_HOST}:${PROXY_SOCKS_PORT}"
        git config --global --add https.proxy "socks5://${PROXY_HOST}:${PROXY_SOCKS_PORT}"
    ;;
    unset)
        git config --global --unset http.proxy
        git config --global --unset https.proxy
    ;;
    print)
        echo "http.proxy:$(git config --global --get http.proxy)"
        echo "https.proxy:$(git config --global --get https.proxy)"
    ;;
    *)
        echo "${0} set|unset|print"
    ;;
esac
