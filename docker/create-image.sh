#!/bin/bash

docker stop snap-builder

mkdir -p build

docker buildx build --iidfile build/snap-builder-pre --file Dockerfile --tag snap-builder-pre docker

docker run \
    --name=snap-builder-pre \
    --privileged \
    --tmpfs /tmp \
    --cap-add SYS_ADMIN \
    --device=/dev/fuse \
    --security-opt apparmor:unconfined \
    --security-opt seccomp:unconfined \
    -d \
    snap-builder-pre

echo "wait for container to boot"
sleep 60

docker exec -it snap-builder-pre snap install --classic snapcraft
docker exec -it snap-builder-pre snap install --classic ubuntu-image

docker commit snap-builder-pre snap-builder

docker stop snap-builder-pre
sleep 5
docker rm snap-builder-pre

