#!/bin/bash

kernel=kernel-qemu-4.4.34-jessie
image=2017-01-11-raspbian-jessie.img
memory=256

# Get kernel image
#wget https://github.com/dhruvvyas90/qemu-rpi-kernel/blob/master/$kernel

# Get raspbian image
# http://downloads.raspberrypi.org/raspbian/images/raspbian-2017-01-10/$kernel

# Update system image
#mkdir -p mnt
#sudo mount -v -o offset=70254592 -t ext4 $image mnt/
#sudo echo "/usr/lib/arm-linux-gnueabihf/libcofi_rpi.so" > mnt/etc/ld.so.preload
#echo "KERNEL==\"sda\", SYMLINK+=\"mmcblk0\"" >> mnt/etc/udev/rules.d/90-qemu.rules
#echo "KERNEL==\"sda?\", SYMLINK+=\"mmcblk0p%n\"" >> mnt/etc/udev/rules.d/90-qemu.rules
#echo "KERNEL==\"sda2\", SYMLINK+=\"root\"" >> mnt/etc/udev/rules.d/90-qemu.rules
#sudo umount mnt

# Run qemu
qemu-system-arm -kernel $kernel -cpu arm1176 -m $memory -M versatilepb -no-reboot -serial stdio -append "root=/dev/sda2 panic=1 rootfstype=ext4 rw init=/bin/bash" -hda $image
