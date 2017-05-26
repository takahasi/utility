#!/bin/bash

sudo apt-get update
sudo apt-get install apt-transport-https ca-certificates

sudo apt-key adv --keyserver hkp://ha.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
echo "deb https://apt.dockerproject.org/repo ubuntu-`lsb_release -cs` main" | sudo tee /etc/apt/sources.list.d/docker.list
sudo apt-get update
sudo apt-get install linux-image-extra-$(uname -r) linux-image-extra-virtual
sudo apt-get install docker-engine

sudo groupadd docker
sudo gpasswd -a $USER docker
echo "please exit"
