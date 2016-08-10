#!/bin/sh
# @(#) This is xxxxxxxxxxxx.

# Checks unnecessary paramters
set -ue

####################
# GLOBAL CONSTANTS #
####################
readonly DISK=disk2
readonly RASPBIAN_URL=https://downloads.raspberrypi.org/raspbian_latest
readonly RASPBIAN_IMG=raspbian.img

################
# MAIN ROUTINE #
################
if [ ! -e ${RASPBIAN_IMG} ]; then
  wget ${RASPBIAN_URL} -O ${RASPBIAN_IMG} --progress=dot
fi

diskutil umountDisk /dev/${DISK}
sudo dd if=${RASPBIAN_IMG} of=/dev/r${DISK} bs=1m
diskutil eject /dev/${DISK}

exit 0
