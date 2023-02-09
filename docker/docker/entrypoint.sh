#!/bin/bash

cat > /usr/local/bin/user_command.sh << EOF
#!/bin/bash

case "$1" in
    init)
        /usr/local/bin/install-snapcraft.sh
        snap install --classic ubuntu-image
        ;;
    bash)
        USER_ID=\$(stat -c '%u' /data)
        GROUP_ID=\$(stat -c '%g' /data)
        bash
        chown "\$USER_ID:\$GROUP_ID" -R /data
        ;;
    *)
        echo "missing command"
        ;;
esac

systemctl exit
EOF
chmod +x /usr/local/bin/user_command.sh

exec /lib/systemd/systemd --system --system-unit user-command.service
