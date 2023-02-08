#!/bin/bash

docker run \
    -it \
    --rm \
    -v $PWD:/data \
    --privileged \
    --tmpfs /tmp \
    --tmpfs /run \
    --tmpfs /run/lock \
    --device=/dev/fuse \
    snap-builder

