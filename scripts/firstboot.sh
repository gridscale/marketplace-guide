#!/bin/bash
SYSTEM_RPW=$(pwgen -sB 12 1)
# change root password
chpasswd <<<"root:$SYSTEM_RPW"

# Get IPv4 Address
V4ADDR=$(ip -4 a l |grep "scope global" | cut -d " " -f 6 | cut -d "/" -f1)
# Get IPv6 Address
V6ADDR=$(ip -6 a l |grep "scope global" | cut -d " " -f 6 | cut -d "/" -f1)
cat -v <<EOF > /etc/issue
======================================================================================
EOF
[[ ! -z $V4ADDR ]] && echo "  http://$V4ADDR/example/" >>/etc/issue
[[ ! -z $V6ADDR ]] && echo "  http://[$V6ADDR]/example/" >>/etc/issue
cat -v <<EOF >> /etc/issue

The initial root password is $SYSTEM_RPW

EOF
# Disable console blanking
echo -ne "\033[9;0]" >> /etc/issue
# generate new ssh keys
dpkg-reconfigure openssh-server
systemctl restart sshd
# restart getty to refresh issue on login
systemctl restart getty@tty1
# cleanup after ourselves
systemctl disable firstboot
rm /etc/systemd/system/firstboot.service
systemctl daemon-reload
rm /firstboot.sh
rm /cleanup.sh
