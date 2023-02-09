#!/bin/bash

#mount -o rw,nosuid,nodev,noexec,relatime securityfs -t securityfs /sys/kernel/security

cat > /usr/local/bin/user_command.sh << EOF
#!/bin/bash

if ! which snapcraft > /dev/null ; then
/usr/local/bin/install-snapcraft.sh
snap install --classic ubuntu-image
else
USER_ID=\$(stat -c '%u' /data)
GROUP_ID=\$(stat -c '%g' /data)
bash
chown "\$USER_ID:\$GROUP_ID" -R /data
fi

systemctl exit \$?
EOF
chmod +x /usr/local/bin/user_command.sh

exec /lib/systemd/systemd --system --system-unit user-command.service
