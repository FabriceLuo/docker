#! /bin/bash
#
# develop.bash
# Copyright (C) 2020 luominghao <luominghao@live.com>
#
# Distributed under terms of the MIT license.
#
set -o pipefail

IMAGE_NAME="develop:2.0"
CONTAINER_NAME="debian10-develop"
WORK_DIR=/home/fabrice/code
LOCAL_VOLUME=/home/mike/code
REMOTE_VOLUME=/home/fabrice/code
USER=fabrice

function start()
{
    echo "begin to start container:${CONTAINER_NAME}"
    docker start "${CONTAINER_NAME}"
    echo "start container success"
}

function stop()
{
    return 0
}

function delete()
{
    echo "begin to delete container:${CONTAINER_NAME}"
    docker container rm -f "${CONTAINER_NAME}"
    echo "delete container success"
}

function create()
{
    echo "begin to create container:${CONTAINER_NAME}"
    docker create -u "${USER}" --workdir "${WORK_DIR}" -v "${LOCAL_VOLUME}":"${REMOTE_VOLUME}" --hostname debian10 -i -t --name "${CONTAINER_NAME}" "${IMAGE_NAME}"
    echo "create container success"
}

function status()
{
    if is_running;then
        echo "develop container is running."
    else
        echo "develop container is not running."
    fi
    return 0
}

function is_running()
{
    docker ps | grep -q "${CONTAINER_NAME}"
}

function attach()
{
    echo "begin to attach container:${CONTAINER_NAME}"
    docker attach "${CONTAINER_NAME}"
}

function enter()
{
    is_running
    if [[ $? -ne 0 ]]; then
        delete
        create
        start
    fi

    attach
}


function usage()
{
    cat <<EOF
$0 usage: $0 status|start|stop|enter|help
EOF
}

case $1 in
    status )
        status
        ;;
    start )
        start
        ;;
    stop )
        stop
        ;;
    enter )
        enter
        ;;
    *)
        usage
        ;;
esac
