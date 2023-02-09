#!/bin/bash

set -e

if which podman > /dev/null ; then
    DOCKER="podman"
    BUILD_COMMAND="image build"
    DOCKER_FLAGS="-v /sys/fs/cgroup:/sys/fs/cgroup:ro"
else
    DOCKER="docker"
    BUILD_COMMAND="build"

    if which sysbox-runc > /dev/null ; then
        DOCKER_FLAGS="--runtime sysbox-runc"
    else
        DOCKER_FLAGS="-v /sys/fs/cgroup:/sys/fs/cgroup:ro \
            --security-opt apparmor:unconfined \
            --security-opt seccomp:unconfined"
    fi
fi

mkdir -p build

$DOCKER $BUILD_COMMAND --iidfile build/snap-builder-pre --file Dockerfile --tag snap-builder-pre docker

$DOCKER run \
    -it \
    --name=snap-builder-pre \
    --tmpfs /tmp \
    --tmpfs /run \
    --tmpfs /run/lock \
    --cap-add SYS_ADMIN \
    --device=/dev/fuse \
    $DOCKER_FLAGS \
    snap-builder-pre init

$DOCKER commit snap-builder-pre snap-builder
$DOCKER rm snap-builder-pre

