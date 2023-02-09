#!/bin/bash

if which snapcraft > /dev/null ; then
exit
fi

# source: https://github.com/snapcore/snapcraft/blob/main/docker/Dockerfile

mkdir -p /snap/snapcraft
snap download --basename snapcraft --target-directory=/tmp snapcraft
unsquashfs -d /snap/snapcraft/current /tmp/snapcraft.snap

unlink /snap/snapcraft/current/usr/bin/python3
ln -s /snap/snapcraft/current/usr/bin/python3.* /snap/snapcraft/current/usr/bin/python3
echo /snap/snapcraft/current/lib/python3.*/site-packages >> /snap/snapcraft/current/usr/lib/python3/dist-packages/site-packages.pth

mkdir -p /snap/bin
snap_version="$(awk '/^version:/{print $2}' /snap/snapcraft/current/meta/snap.yaml | tr -d \')"
cat > /snap/bin/snapcraft << EOF
#!/bin/sh

export PATH="/snap/bin:/snap/snapcraft/current/usr/bin:\$PATH"
export SNAP="/snap/snapcraft/current"
export SNAP_NAME="snapcraft"
export SNAP_ARCH="amd64"
export SNAP_VERSION="$snap_version"

exec "\$SNAP/usr/bin/python3" "\$SNAP/bin/snapcraft" "\$@"
EOF
chmod +x /snap/bin/snapcraft
