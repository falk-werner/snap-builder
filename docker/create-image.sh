#!/bin/bash

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
    -v /sys/fs/cgroup:/sys/fs/cgroup:ro \
    --security-opt apparmor:unconfined \
    --security-opt seccomp:unconfined  \
    snap-builder-pre

#    --privileged \


docker commit snap-builder-pre snap-builder
docker rm snap-builder-pre

