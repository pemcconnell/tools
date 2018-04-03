#!/usr/bin/env sh

set +x

echo $(pwd)

env > .env_file

docker run \
    --env-file .env_file \
    -v $(pwd)/src:/root/src \
    -ti tools:dev \
    $@

rm -f .env_file
