#!/bin/bash

docker run \
    --name=snap-builder \
    --rm \
    --privileged \
    --tmpfs /tmp \
    --cap-add SYS_ADMIN \
    --device=/dev/fuse \
    --security-opt apparmor:unconfined \
    --security-opt seccomp:unconfined \
    -d \
    snap-builder

docker exec -it snap-builder bash

docker stop snap-builder
