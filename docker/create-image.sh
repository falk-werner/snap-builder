#!/bin/bash

mkdir -p build

docker buildx build --iidfile build/snap-builder-pre --file Dockerfile --tag snap-builder-pre docker

docker run \
    -it \
    --name=snap-builder-pre \
    --privileged \
    --tmpfs /tmp \
    --tmpfs /run \
    --tmpfs /run/lock \
    --device=/dev/fuse \
    snap-builder-pre

docker commit snap-builder-pre snap-builder
docker rm snap-builder-pre

