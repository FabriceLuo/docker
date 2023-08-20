#!/bin/bash


function start() {
	docker stop postgres-ins
	docker rm postgres-ins
	umount /mnt/postgres
	qemu-nbd -d /dev/nbd11

	qemu-nbd -c /dev/nbd11 /mnt/backup/data/20230316/postgres/server-db.qcow2
	if [[ $? -ne 0 ]];then
		echo "connect postgres qcow2 file to nbd failed"
		return 1
	fi
	/usr/bin/partx --update /dev/nbd11

	mount /dev/nbd11p1 /mnt/postgres/
	if [[ $? -ne 0 ]];then
		echo "mount postgres blk failed"
		return 1
	fi

	docker run -d --rm --name postgres-ins -e PGDATA=/var/lib/postgresql/data  -p 54320:5432 -v /mnt/postgres/data:/var/lib/postgresql/data postgres:11.18-bullseye
}


case $1 in
    stop)
        stop
        ;;
    start)
        start
        ;;
    status)
	;;
    *)
        echo "command not found, commond:$1"
        ;;
esac

