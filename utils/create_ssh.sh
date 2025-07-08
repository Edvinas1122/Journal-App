#!/bin/bash
if [ ! -f /etc/ssh/ssh_host_rsa_key ]; then
    ssh-keygen -A
    ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key -N ""
    echo "SSH Public Key:"
    ssh-keygen -y -f /etc/ssh/ssh_host_rsa_key
fi

exec /usr/sbin/sshd -D
