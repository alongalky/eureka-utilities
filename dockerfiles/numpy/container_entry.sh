#!/bin/sh

echo $1 > /root/.ssh/authorized_keys
/usr/sbin/sshd -D
