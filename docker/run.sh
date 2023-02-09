#!/bin/bash

docker run \
    -it \
    --rm \
    -v $PWD:/data \
    --tmpfs /tmp \
    --tmpfs /run \
    --tmpfs /run/lock \
    --cap-add SYS_ADMIN \
    --device=/dev/fuse \
    -v /sys/fs/cgroup:/sys/fs/cgroup:ro \
    --security-opt apparmor:unconfined \
    --security-opt seccomp:unconfined  \
    snap-builder

