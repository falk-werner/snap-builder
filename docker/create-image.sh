#!/bin/bash

if which sysbox-runc > /dev/null ; then
DOCKER_FLAGS="--runtime sysbox-runc"
else
DOCKER_FLAGS=\
    "-v /sys/fs/cgroup:/sys/fs/cgroup:ro \
    --security-opt apparmor:unconfined \
    --security-opt seccomp:unconfined"
fi

mkdir -p build

docker buildx build --iidfile build/snap-builder-pre --file Dockerfile --tag snap-builder-pre docker

docker run \
    -it \
    --name=snap-builder-pre \
    --tmpfs /tmp \
    --tmpfs /run \
    --tmpfs /run/lock \
    --cap-add SYS_ADMIN \
    --device=/dev/fuse \
    $DOCKER_FLAGS \
    snap-builder-pre init

docker commit snap-builder-pre snap-builder
docker rm snap-builder-pre

