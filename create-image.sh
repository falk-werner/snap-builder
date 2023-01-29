#!/bin/bash

# check requirements
# sudo apt install wget cloud-image-utils qemu-system-x86 genisoimage

if ! which wget > /dev/null ; then
	echo "error: wget not found: please install wget"
	exit 1
fi

if ! which qemu-system-x86_64 > /dev/null ; then
	echo "error: qemu-system-x86_64 not found: please install qemu-system-x86"
	exit 1
fi

if ! which isoinfo > /dev/null ; then
	echo "error: isoinfo not found: please install genisoimage"
	exit 1
fi

if ! which cloud-localds > /dev/null ; then
	echo "error: cloud-localds not found: please install cloud-image-utils"
fi


# Download image and extract kernel
mkdir -p build

if ! md5sum -c ubuntu-22.10-live-server-amd64.iso.md5 > /dev/null ; then
	wget -P build https://releases.ubuntu.com/22.10/ubuntu-22.10-live-server-amd64.iso
	rm build/vmlinuz
	rm build/initrd
fi

# extract kernel
if [[ ! -f build/vmlinuz ]] ; then
	isoinfo -i build/ubuntu-22.10-live-server-amd64.iso -J -x '/casper/vmlinuz' > build/vmlinuz
fi

if [[ ! -f build/initrd ]] ; then
	isoinfo -i build/ubuntu-22.10-live-server-amd64.iso -J -x '/casper/initrd' > build/initrd
fi


# create image file
rm -f build/snap-builder.img
truncate -s 10G build/snap-builder.img

# create seed image
cloud-localds build/seed.iso user-data meta-data

# create system

KVM_OPTIONS=""
if which kvm-ok > /dev/null && kvm-ok > /dev/null ; then
KVM_OPTIONS="-enable-kvm -cpu host"
fi

qemu-system-x86_64 -no-reboot -smp 2 -m 4G \
	$(KVM_OPTIONS) \
	-drive file=build/snap-builder.img,format=raw,cache=none,if=virtio \
	-drive file=build/seed.iso,format=raw,cache=none,if=virtio \
	-cdrom build/ubuntu-22.10-live-server-amd64.iso \
	-kernel ./build/vmlinuz \
	-initrd ./build/initrd \
	-append 'panic=-1 autoinstall console=ttyS0 ds=nocloud' \
	-nographic \
	-serial mon:stdio

