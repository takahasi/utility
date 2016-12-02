#!/bin/bash

wget http://svn.openrtm.org/OpenRTM-aist/tags/RELEASE_1_1_2/OpenRTM-aist/installer/install_scripts/pkg_install_debian.sh

sudo sh pkg_install_python_debian.sh

git clone https://github.com/fluent/fluent-bit.git

(cd fluent-bit/build && cmake .. && make && suo make install)

exit 0
