#!/bin/bash

docker run \
    -it \
    --rm \
    -v $PWD:/data \
    --privileged \
    --tmpfs /tmp \
    --cap-add SYS_ADMIN \
    --device=/dev/fuse \
    --security-opt apparmor:unconfined \
    --security-opt seccomp:unconfined \
    snap-builder

