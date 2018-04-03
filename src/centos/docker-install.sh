#!/bin/bash

set -e

# Install pip
sudo easy_install pip
sudo pip install --upgrade --force-reinstall pip==9.0.3

# Install docker
sudo yum install -y yum-utils device-mapper-persistent-data lvm2
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
sudo yum-config-manager --enable docker-ce-edge
sudo yum-config-manager --enable docker-ce-test
sudo yum install -y docker-ce git
sudo systemctl enable docker
sudo systemctl start docker
sudo groupadd docker
sudo usermod -aG docker $USER


# Install docker-compose
sudo pip install docker-compose

# Upgrade pip
sudo pip install --upgrade pip
