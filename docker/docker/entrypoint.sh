#!/bin/bash

mount -o rw,nosuid,nodev,noexec,relatime securityfs -t securityfs /sys/kernel/security

mount -t tmpfs tmpfs /run
mount -t tmpfs tmpfs /run/lock

cat > /usr/local/bin/user_command.sh << EOF
#!/bin/bash

if ! which snapcraft > /dev/null ; then
snap install --classic snapcraft
snap install --classic ubuntu-image
else
bash
fi

systemctl exit \$?
EOF
chmod +x /usr/local/bin/user_command.sh

#exec /sbin/init
exec /lib/systemd/systemd --system --system-unit user-command.service
