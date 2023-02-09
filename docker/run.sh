#!/bin/bash

if which sysbox-runc > /dev/null ; then
DOCKER_FLAGS="--runtime sysbox-runc"
else
DOCKER_FLAGS=\
    "-v /sys/fs/cgroup:/sys/fs/cgroup:ro \
    --security-opt apparmor:unconfined \
    --security-opt seccomp:unconfined"
fi


docker run \
    -it \
    --rm \
    -v $PWD:/data \
    --tmpfs /tmp \
    --tmpfs /run \
    --tmpfs /run/lock \
    --cap-add SYS_ADMIN \
    --device=/dev/fuse \
    $DOCKER_FLAGS \
    snap-builder bash
