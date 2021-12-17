#! /bin/bash
#
# develop-docker-for-self-host.bash
# Copyright (C) 2021 fabriceluo <fabriceluo@outlook.com>
#
# Distributed under terms of the MIT license.
#
# develop docker controller on self-host.


CONTAINER_NAME="develop-ins"
IMAGE_NAME="develop"
IMAGE_TAG="3.1"


get_container_id() {
    local name=$1

    if [[ -z "${name}" ]]; then
        return 1
    fi

    docker ps --filter "name=${name}" --format "{{.ID}}"
}

is_container_running() {
    local name=$1
    local containerid=

    if ! containerid=$(get_container_id "${name}");then
        echo "get container(${name}) id failed"
        return 2
    fi

    if [[ -z "${containerid}" ]]; then
        return 1
    fi

    return 0
}

start_develop() {
    docker run -it --rm --hostname debian10 --user fabrice --name "${CONTAINER_NAME}" -v /home/mike/code:/home/fabrice/code "${IMAGE_NAME}":"${IMAGE_TAG}"
}

stop_develop() {
    docker stop "${CONTAINER_NAME}"
    return 0
}

status_develop() {
    if is_container_running "${CONTAINER_NAME}";then
        echo "develop is running"
    else
        echo "develop is not running"
    fi
    return 0
}

attach_develop() {
    docker attach "${CONTAINER_NAME}"
}


case $1 in
    start)
        start_develop
        ;;
    stop)
        stop_develop
        ;;
    restart)
        stop_develop
        start_develop
        ;;
    attach)
        attach_develop
        ;;
    status)
        status_develop
        ;;
    *)
        status_develop
        ;;
esac
