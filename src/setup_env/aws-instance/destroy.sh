#!/usr/bin/env bash

set +x

source .env
terraform destroy -auto-approve
