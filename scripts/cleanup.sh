#!/bin/bash

rm -rf /tmp/* /var/tmp/*
history -c
cat /dev/null > /root/.bash_history
unset HISTFILE

apt-get -y autoremove
apt-get -y autoclean

rm -f /root/.ssh/authorized_keys /etc/ssh/*key*

cat /dev/null > /var/log/lastlog; cat /dev/null > /var/log/wtmp; cat /dev/null > /var/log/auth.log

# prompt to update hostname
# prompt to regenerate the machine ID
rm -rf <path/to/this/script>
shutdown
