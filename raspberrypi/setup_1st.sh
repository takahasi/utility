#!/bin/sh
# @(#) This is xxxxxxxxxxxx.

# Checks unnecessary paramters
set -ue

####################
# GLOBAL CONSTANTS #
####################

################
# MAIN ROUTINE #
################
wget http://svn.openrtm.org/OpenRTM-aist/tags/RELEASE_1_1_2/OpenRTM-aist/build/pkg_install_debian.sh
chmod a+x pkg_install_debian.sh
sudo ./pkg_install_debian.sh

http://svn.openrtm.org/OpenRTM-aist-Python/tags/RELEASE_1_1_2/OpenRTM-aist-Python/installer/install_scripts/pkg_install_python_debian.sh
chmod a+x pkg_install_python_debian.sh
sudo ./pkg_install_python_debian.sh

exit 0
