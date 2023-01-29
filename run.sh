#!/bin/bash

KVM_OPTIONS=""
if which kvm-ok > /dev/null && kvm-ok > /dev/null ; then
KVM_OPTIONS="-enable-kvm -cpu host"
fi

qemu-system-x86_64 -no-reboot -smp 2 -m 4G \
	$(KVM_OPTIONS) \
	-net user,hostfwd=tcp::8022-:22 \
	-drive file=build/snap-builder.img,format=raw,cache=none,if=virtio \
	-serial mon:stdio \
	-nographic \
	-snapshot


