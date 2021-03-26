#!/bin/bash
yum install -y autofs* nfs-utils*
systemctl restart nfs-server
firewall-cmd --permanent --add-service={nfs,rpc-bind,mountd}
firewall-cmd --reload
mkdir /Dirshare
# add the other computer's ip
echo "/Dirshare 192.168.1.1(rw,sync,no_root_squash)" > /etc/exports
systemctl restart nfs-server

