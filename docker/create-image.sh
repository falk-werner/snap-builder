#!/bin/bash

mkdir -p build

docker buildx build --iidfile build/snap-builder-pre --file Dockerfile --tag snap-builder-pre docker

docker run \
    -it \
    --name=snap-builder-pre \
    --privileged \
    --tmpfs /tmp \
    --cap-add SYS_ADMIN \
    --device=/dev/fuse \
    --security-opt apparmor:unconfined \
    --security-opt seccomp:unconfined \
    snap-builder-pre

docker commit snap-builder-pre snap-builder

docker stop snap-builder-pre
sleep 5
docker rm snap-builder-pre

