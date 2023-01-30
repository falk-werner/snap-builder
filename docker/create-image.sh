#!/bin/bash

mkdir -p build

docker buildx build --iidfile build/snap-builder --file Dockerfile --tag snap-builder docker

