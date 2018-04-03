#!/usr/bin/env sh

set +x

docker -D build \
    --network host \
    -t tools:dev \
    .
