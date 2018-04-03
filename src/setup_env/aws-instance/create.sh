#!/usr/bin/env bash

set +x

source .env
terraform apply -auto-approve
