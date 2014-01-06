#!/bin/bash

set -e
set -x

## just in case we cd
me="${0}"

## @todo generate key and configure key-only auth
## sed -i -e 's/^PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config

yum localinstall -y https://asl-docker.s3.amazonaws.com/el6/asl-docker-1.0-1.noarch.rpm
yum install -y python-supervisor openssh-server passwd rootfiles

sed -i -e 's/^#PermitRootLogin.*/PermitRootLogin yes/' /etc/ssh/sshd_config

## http://gaijin-nippon.blogspot.com/2013/07/audit-on-lxc-host.html
sed -i -e '/pam_login/d' /etc/pam.d/sshd
sed -i -e '/pam_login/d' /etc/pam.d/login

echo d0ck3r | passwd --stdin root

## start ssh once to create host keys
/etc/rc.d/init.d/sshd start

yum clean all
mkdir -p /etc/supervisor.d /var/log/supervisor

rm -f "${me}"
