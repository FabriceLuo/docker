#! /bin/bash
#
# nextcloud control script.
# Copyright (C) 2021 fabriceluo <fabriceluo@outlook.com>
#
# Distributed under terms of the MIT license.
#
set -o pipefail

NEXTCLOUD_INS_NAME="nextcloud_instance"
VDISK_DIR="/mnt/data/qcow2/nextcloud"

declare -A QCOW2_SIZE=( \
    ["nextcloud_data.qcow2"]="2048G" \
    ["nextcloud_config.qcow2"]="50G" \
    ["nextcloud.qcow2"]="50G" \
    ["nextcloud_apps.qcow2"]="50G" \
    ["nextcloud_theme.qcow2"]="50G" \
)

declare -A QCOW2_MOUNTS=( \
    ["nextcloud_data.qcow2"]="/mnt/nextcloud/data" \
    ["nextcloud_config.qcow2"]="/mnt/nextcloud/config" \
    ["nextcloud.qcow2"]="/mnt/nextcloud/nextcloud" \
    ["nextcloud_apps.qcow2"]="/mnt/nextcloud/apps" \
    ["nextcloud_theme.qcow2"]="/mnt/nextcloud/theme" \
)

declare -A QCOW2_MAPS=( \
    ["nextcloud_data.qcow2"]="/dev/nbd2" \
    ["nextcloud_config.qcow2"]="/dev/nbd3" \
    ["nextcloud.qcow2"]="/dev/nbd4" \
    ["nextcloud_apps.qcow2"]="/dev/nbd5" \
    ["nextcloud_theme.qcow2"]="/dev/nbd6" \
)

function get_unused_nbd() {
    for nbd in /dev/nbd*;
    do
        if ! lsblk -d -b -n -o SIZE $nbd >/dev/null 2>&1;then
            echo $nbd
            return 0
        fi
    done
    return 1
}

function mount_all() {
    local nbd=

}

function create_disks() {
    local nbd=
    for qcow2_name in ${!QCOW2_SIZE[@]};
    do
        qcow2_path="${VDISK_DIR}/${qcow2_name}"
        if [[ -f "${qcow2_path}" ]];then
            echo "qcow2 file(${qcow2_path}) exist!"
            return 1
        fi

        echo "create image ${qcow2_path}"
        if ! qemu-img create -f qcow2 "${qcow2_path}" ${QCOW2_SIZE[$qcow2_name]};then
            echo "create qcow2 file(${qcow2_path}) failed!"
            return 1
        fi

        if ! nbd=$(get_unused_nbd);then
            echo "get unused nbd failed"
            return 1
        fi

        if ! qemu-nbd -c $nbd "${qcow2_path}";then
            echo "connect qcow2 to nbd failed"
            return 1
        fi

        echo "mkfs for image ${qcow2_path}"
        if ! mkfs.ext4 $nbd;then
            echo "create ext4 fs failed"
            return 1
        fi

        sync

        if ! qemu-nbd -d $nbd;then
            echo "disconnect nbd failed"
            return 1
        fi
    done

}

function disconnect_devs() {
    for qcow2_name in ${!QCOW2_MAPS[@]};
    do
        nbd_path=${QCOW2_MAPS[$qcow2_name]}
        if [[ -z $nbd_path ]];then
            echo "nbd path error"
            return 1
        fi

        if ! sudo qemu-nbd -d "${nbd_path}";then
            echo "disconnect nbd path(${nbd_path}) failed"
            return 2
        fi
    done

    return 0
}

function is_device_online() {
    device_path=$1

    if device_size=$(lsblk -n -b -o SIZE "${device_path}");then
        echo "get device size failed"
        return 2
    fi

    if [[ $deivce_size -ne 0 ]];then
        return 0
    fi

    return 1
}

function connect_devs() {
    for qcow2_name in ${!QCOW2_MAPS[@]};
    do
        qcow2_path="${VDISK_DIR}/${qcow2_name}"
        nbd_path=${QCOW2_MAPS[$qcow2_name]}

        # 存在时就不再挂载，直接失败
        is_device_online "${nbd_path}"
        if [[ $? -ne 1 ]]; then
            echo "device(${nbd_path}) is online or error"
            return 1
        fi

        if ! sudo qemu-nbd -c "${nbd_path}" "${qcow2_path}";then
            echo "disconnect nbd path(${nbd_path}) failed"
            return 2
        fi
    done

    sudo partprobe

    return 0
}

function is_running() {
    if ! status=$(docker inspect "${NEXTCLOUD_INS_NAME}" | jq -r .[].State.Status);then
        echo "get instance running status failed"
        return 2
    fi

    if [[ "${status}" != "running" ]]; then
        return 1
    fi

    return 0
}

function start_nextcloud() {
    docker run -d -it -p 8090:80 -p 8091:443 \
        -v nextcloud:/var/www/html \
        -v nextcloud_apps:/var/www/html/custom_apps \
        -v nextcloud-test-config:/var/www/html/config \
        -v nextcloud-test-data:/var/www/html/data \
        -v nextcloud_theme:/var/www/html/themes \
        --name "${NEXTCLOUD_INS_NAME}" nextcloud-image:1.0
}

function stop_nextcloud() {
    docker stop "${NEXTCLOUD_INS_NAME}"
}

function stop() {
    if ! is_running;then
        echo "instance is not running"
        return 1
    fi

    if ! stop_nextcloud;then
        echo "stop nextcloud server failed"
        return 1
    fi

    if ! disconnect_devs;then
        echo "disconnect devices failed"
        return 1
    fi

    return 0
}

function start() {
    if is_running;then
        echo "instance is running or status error"
        return 2
    fi

    if ! disconnect_devs;then
        echo "disconnect devices failed"
        return 1
    fi
    echo "disconnect devices success"

    if ! connect_devs;then
        echo "connect devices failed"
        return 1
    fi
    echo "connect devices success"

    if ! start_nextcloud;then
        echo "start nextcloud server failed"
        return 1
    fi
    echo "start nextcloud server success"

    return 0
}

case $1 in
    stop)
        stop
        ;;
    start)
        start
        ;;
    *)
        echo "command not found, commond:$1"
        ;;
esac
