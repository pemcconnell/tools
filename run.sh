#!/usr/bin/env sh

set +x

echo $(pwd)

docker run \
    -e AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID} \
    -e AWS_DEFAULT_REGION=${AWS_DEFAULT_REGION} \
    -e AWS_REGION=${AWS_REGION} \
    -e AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY} \
    -e AWS_SECURITY_TOKEN=${AWS_SECURITY_TOKEN} \
    -e AWS_SESSION_TOKEN=${AWS_SESSION_TOKEN} \
    -e AWS_VAULT=${AWS_VAULT} \
    -e AWS_VAULT_BACKEND=${AWS_VAULT_BACKEND} \
    -v $(pwd)/src:/root/src \
    -ti tools:dev \
    $@
