# snap-builder

Setup an VM for building snaps.

## Build

    ./create-image.sh
    ./first-boot.sh

## Run

    ./run.sh

## Dependencies

- cloud-image-utils
- genisoimage
- qemu-system-x86
- wget
- kvm _(optional)_

## References

- (https://ubuntu.com/server/docs/install/autoinstall)[https://ubuntu.com/server/docs/install/autoinstall]
- (https://cloudinit.readthedocs.io/en/latest/reference/examples.html)[https://cloudinit.readthedocs.io/en/latest/reference/examples.html]
- (https://leftasexercise.com/2020/04/12/understanding-cloud-init/)[https://leftasexercise.com/2020/04/12/understanding-cloud-init/]
