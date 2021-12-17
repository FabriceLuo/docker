#! /usr/bin/env python3
# -*- coding: utf-8 -*-
# vim:fenc=utf-8
#
# Copyright © 2021 fabriceluo <fabriceluo@outlook.com>
#
# Distributed under terms of the MIT license.

"""
nextcloud instance controller.
"""

import os
import re
import sys
import logging as LOG
import subprocess

BYTES_OF_GB = 1024 * 1024 * 1024
NBD_MAX_INDEX = 16

LOG.basicConfig(level=LOG.DEBUG)


def gb_to_byte(gb):
    return int(gb * BYTES_OF_GB)


class Volume(object):
    def __init__(self, name, image, size_byte, mount_name,
                 data_root, mount_root):
        self._name = name
        self._image = image
        self._size_byte = size_byte
        self._mount_name = mount_name

        self._data_root = data_root
        self._mount_root = mount_root
        self._image_path = os.path.join(data_root, self._image)
        self._mount_path = os.path.join(mount_root, self._mount_name)

    @property
    def name(self):
        return self._name

    @property
    def image(self):
        return self._image

    @property
    def size_byte(self):
        return self._size_byte

    @property
    def mount_name(self):
        return self._mount_name

    @property
    def mount_path(self):
        return self._mount_path

    def mount(self):
        self._umount_image()

        self._mount_block()

    def _mount_block(self):
        block = self._mount_image()

        self.mountfs(block, self._mount_path)

    def _mount_image(self):
        return self._connect_image_to_block()

    def umount(self):
        LOG.info('umount volume:%s', self.name)
        self._umount_image()

    def _umount_image(self):
        self._umount_block()

        nbds = self.get_nbds_of_image(self._image_path)
        for nbd in nbds:
            LOG.info('disconnect image nbd(%s)', nbd)
            self.disconnect_nbd(nbd)

    def _umount_block(self):
        if not os.path.isdir(self._mount_path):
            LOG.debug('mount path(%s) not exist', self._mount_path)
            return

        command = ['mountpoint', '-q', self._mount_path]
        process = subprocess.run(command)

        if process.returncode == 1:
            LOG.warn('mount path(%s) is not a mount point', self._mount_path)
        elif process.returncode == 0:
            command = ['umount', self._mount_path]
            LOG.info('run umount command', command)
            subprocess.run(command, check=True)
        else:
            LOG.error('get mount point(%s) status error', self._mount_path)
            raise OSError(process.stderr)

    @staticmethod
    def get_usable_nbd():
        for i in range(NBD_MAX_INDEX):
            nbd = '/dev/nbd%s' % i

            if not os.path.exists(nbd):
                LOG.warn('nbd(%s) not found', nbd)
                continue

            command = ['lsblk', '-b', '-o', 'SIZE', nbd]
            process = subprocess.run(command)

            if process.returncode != 32:
                # LOG.warn('lsblk nbd exit status:%s', process.exitcode)
                continue

            LOG.info('found usable nbd(%s)', nbd)
            return nbd

    @staticmethod
    def get_pids_of_openfile(path):
        command = ['lsof', '-t', path]

        process = subprocess.run(command)

        if process.returncode != 0:
            LOG.warn('get file(%s) open processes failed, err:%s',
                     path,
                     process.stderr)
            return []

        return process.stdout.split()

    @staticmethod
    def get_nbd_of_process(pid):
        cmdline_file = '/proc/%s/cmdline' % pid

        with open(cmdline_file) as fp:
            cmdline = fp.readline().replace('\0', ' ')
            pass

        LOG.debug('get process(%s) nbd from cmdline(%s)', pid, cmdline)
        match = re.match(r'^qemu-nbd -c (?P<nbd>\w*) \w*$', cmdline)
        if not match:
            return None

        return match.group['nbd']

    @staticmethod
    def get_nbds_of_processes(pids):
        nbds = []
        for pid in pids:
            nbd = Volume.get_nbd_of_process(pid)
            if not nbd:
                continue
            nbds.append(nbd)
            pass

        return nbds

    @staticmethod
    def get_nbds_of_image(image):
        pids = Volume.get_pids_of_openfile(image)
        LOG.info('image(%s) is opened by pids(%s)', image, pids)

        nbds = Volume.get_nbds_of_processes(pids)
        LOG.info('nbds(%s) is binding to image(%s)', nbds, image)

        return nbds

    @staticmethod
    def mountfs(block, mount_path):
        mount_parent = os.path.dirname(mount_path)
        if not os.path.isdir(mount_parent):
            LOG.error('mount parent(%s) not exists', mount_parent)
            raise FileNotFoundError(mount_parent)

        if not os.path.exists(mount_path):
            LOG.info('mount path(%s) not found, create it', mount_path)
            os.mkdir(mount_path)

        command = ['mount', block, mount_path]
        LOG.info('mount block(%s) at path(%s) with command(%s)',
                 block,
                 mount_path,
                 command)

        subprocess.run(command, check=True)

    @staticmethod
    def mkfs(block, fmt='ext4'):
        if not os.path.exists(block):
            LOG.error('nbd device(%s) not found', block)
            raise FileNotFoundError(block)

        command = ['mkfs', '-t', fmt, block]
        LOG.info('make fs(%s) for device(%s)', fmt, block)
        subprocess.run(command, check=True)

    @staticmethod
    def disconnect_nbd(nbd):
        LOG.info('disconnect nbd block:%s', nbd)

        command = ['qemu-nbd', '-d', nbd]
        LOG.info('disconnect nbd with command:%s', command)

        subprocess.run(command, check=True)

    @staticmethod
    def create_qcow2(path, size_byte):
        LOG.info('create image:%s, size byte:%s', path, size_byte)

        command = ['qemu-img', 'create', '-f', 'qcow2', path, str(size_byte)]
        LOG.info('crate image with command:%s', command)

        subprocess.run(command, check=True)

    def _create_image(self):
        LOG.info('create qcow2 image file(%s), size(%s)',
                 self._image_path,
                 self._size_byte)
        self.create_qcow2(self._image_path, self._size_byte)

    def _connect_image_to_block(self):
        nbd = self.get_usable_nbd()

        LOG.info('connect image(%s) to nbd(%s)', self._image_path, nbd)

        if not os.path.isfile(self._image_path):
            LOG.error('image(%s) is not a plain file', self._image_path)
            raise FileNotFoundError(self._image_path)

        if not os.path.exists(nbd):
            LOG.error('nbd device(%s) not found', nbd)
            raise FileNotFoundError(nbd)

        command = ['qemu-nbd', '-c', nbd, self._image_path]
        LOG.info('run command:%s', command)
        subprocess.run(command, check=True)

        return nbd

    def _disconnect_image_to_block(self, block):
        LOG.info('disconnect nbd block(%s) from image(%s)',
                 block,
                 self._image_path)

        self.disconnect_nbd(block)

    def _format_image(self):
        block = self._connect_image_to_block()

        try:
            self.mkfs(block)
            LOG.info('create fs on block(%s) success.', block)
        finally:
            self._disconnect_image_to_block(block)

    def create(self):
        if os.path.exists(self._image_path):
            LOG.error('image path(%s) is exist.', self._image_path)
            raise FileExistsError(self._image_path)

        self._create_image()

        self._format_image()


class Nextcloud(object):
    DOCKER_IMAGE_REP = "nextcloud-image"
    DOCKER_IAMGE_TAG = "1.0"
    CONTAINER_NAME = "nextcloud-ins"

    DATA_ROOT = '/home/mike/data/nextcloud'
    MOUNT_ROOT = '/mnt/nextcloud'
    VOLUMES = [
        {
            'name': 'data',
            'image': 'data.qcow2',
            'size_byte': gb_to_byte(2048),
            'mount_name': 'data',
            'bind_path': '/var/www/html/data',
        },
        {
            'name': 'config',
            'image': 'config.qcow2',
            'size_byte': gb_to_byte(50),
            'mount_name': 'config',
            'bind_path': '/var/www/html/config',
        },
        {
            'name': 'nextcloud',
            'image': 'nextcloud.qcow2',
            'size_byte': gb_to_byte(50),
            'mount_name': 'nextcloud',
            'bind_path': '/var/www/html',
        },
        {
            'name': 'apps',
            'image': 'apps.qcow2',
            'size_byte': gb_to_byte(50),
            'mount_name': 'apps',
            'bind_path': '/var/www/html/apps',
        },
        {
            'name': 'theme',
            'image': 'theme.qcow2',
            'size_byte': gb_to_byte(50),
            'mount_name': 'theme',
            'bind_path': '/var/www/html/themes',
        },
    ]

    def __init__(self):
        self._volumes = []
        self._instance_volumes()

    def _instance_volumes(self):
        for v in self.VOLUMES:
            LOG.info('init volume(%s)', v)
            ins = Volume(v['name'],
                         v['image'],
                         v['size_byte'],
                         v['mount_name'],
                         self.DATA_ROOT,
                         self.MOUNT_ROOT)
            self._volumes.append(ins)

    @staticmethod
    def must_dir_exist_and_empty(path):
        if not os.path.exists(path):
            LOG.fatal('path not exist, path:%s', path)

        if not os.path.isdir(path):
            LOG.fatal('path is not a dir, path:%s', path)

        if os.listdir(path):
            LOG.fatal('path not empty, dir:%s', path)

    def initialize(self):
        self.must_dir_exist_and_empty(self.DATA_ROOT)

        if not os.path.isdir(self.MOUNT_ROOT):
            LOG.fatal('mount root(%s) is not exists', self.MOUNT_ROOT)

        self._init_volumes()

    def _init_volumes(self):
        for volume in self._volumes:
            LOG.info('create volume(%s)', volume)
            volume.create()

    def _mount_volumes(self):
        for volume in self._volumes:
            LOG.info('mount volume(%s)', volume)
            volume.mount()

    def _umount_volumes(self):
        for volume in self._volumes:
            LOG.info('mount volume(%s)', volume)
            volume.umount()

    @classmethod
    def _get_volume_bind_path(cls, volume):
        for volume_config in cls.VOLUMES:
            if volume_config['name'] != volume.name:
                continue

            return volume_config['bind_path']

    def _get_start_container_cmd(self):
        docker_cmd = [
            "docker",
            "run"
        ]
        opts = [
            "-d",
            "-it",
            "-p", "8090:80",
            "-p", "8091:443",
            "-name", self.CONTAINER_NAME,
            ':'.join(self.DOCKER_IMAGE_REP, self.DOCKER_IMAGE_TAG),
        ]

        volume_opts = []
        for volume in self._volumes:
            bind_path = self._get_volume_bind_path(volume)
            if bind_path is None:
                LOG.error('get volume(%s) bind path failed', volume)
                raise RuntimeError('volume(%s) bind path not found' % volume)

            volume_bind = ":".join(volume.mount_path, bind_path)

            volume_opts.extend("-v", volume_bind)

        
        return docker_cmd + volume_opts + opts

    def _start_container(self):
        command = self._get_start_container_cmd()

        LOG.info('start nextcloud container, cmd:%s', command)
        subprocess.run(command, check=True)

    def _get_stop_container_cmd(self):
        command = [
            "docker",
            "stop",
            self.CONTAINER_NAME
        ]

        return command

    def _stop_container(self):
        command = self._get_stop_container_cmd()

        LOG.info('stop nextcloud container, cmd:%s', command)
        # FIXME: 先检查运行状态，运行时再进行stop
        subprocess.run(command, check=True)

    def start(self):
        self._umount_volumes()

        self._mount_volumes()

        try:
            self._start_container()
        except Exception:
            LOG.exception('start container failed')
            self._umount_volumes()
            raise

    def stop(self):

        self._stop_container()

        self._umount_volumes()


def main():
    if len(sys.argv) == 1:
        command = 'status'
    else:
        command = sys.argv[1]

    nextcloud = Nextcloud()

    if command.startswith('_') or not hasattr(nextcloud, command):
        LOG.error('command(%s) not found', command)
        raise NameError('command(%s) not found' % command)

    func = getattr(nextcloud, command)
    func()

if __name__ == '__main__':
    main()
