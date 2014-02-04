#!/bin/bash

set -e
set -x

cd /tmp/src

yum localinstall -y https://asl-docker.s3.amazonaws.com/el6/asl-docker-1.0-1.noarch.rpm

yum install -y python-supervisor openssh-server passwd rootfiles cronie logstash-forwarder

## copy files into place
tar -c -C skel -f - . | tar -xf - -C /

## required log dir for supervisor
mkdir -p /var/log/supervisor

## === SSH CONFIG

## @todo generate key and configure key-only auth
## sed -i -e 's/^PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config

## allow root to log in
sed -i -e 's/^#PermitRootLogin.*/PermitRootLogin yes/' /etc/ssh/sshd_config

echo d0ck3r | passwd --stdin root

## http://gaijin-nippon.blogspot.com/2013/07/audit-on-lxc-host.html
sed -i -e '/pam_login/d' /etc/pam.d/sshd
sed -i -e '/pam_login/d' /etc/pam.d/login

## prevent sshd from daemonizing
echo 'OPTIONS="-D"' >> /etc/sysconfig/sshd

## === CROND CONFIG

## relax pam to let cron run
## http://lists.freedesktop.org/archives/systemd-devel/2013-May/010944.html
sed -i -E -e 's/^(.*pam_loginuid.so)$/#\1/g' /etc/pam.d/crond

## === CLEANUP
cd /
yum clean all
rm -rf /var/tmp/yum-root* /tmp/src
