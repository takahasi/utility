#!/bin/bash

sudo apt-get update

if [ ! type "wget" > /dev/null 2>&1 ]; then
  sudo apt-get install wget
fi

if [ ! type "git" > /dev/null 2>&1 ]; then
  sudo apt-get install git
fi

if [ ! type "cmake" > /dev/null 2>&1 ]; then
  sudo apt-get install cmake
fi


wget http://svn.openrtm.org/OpenRTM-aist/tags/RELEASE_1_1_2/OpenRTM-aist/build/pkg_install_debian.sh
sudo sh pkg_install_debian.sh

git clone https://github.com/fluent/fluent-bit.git

(cd fluent-bit/build && cmake .. && make && suo make install)

exit 0
