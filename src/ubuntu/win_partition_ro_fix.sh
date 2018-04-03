#!/bin/bash

sudo ntfsfix /dev/nvme0n1p2
sudo umount /data
sudo mount -n -o rw /data
