#!/bin/bash
useradd wallah
echo "passcontaineruser" | passwd --stdin wallah
yum install container-tools -y
exit


ssh wallah@192.168.1.101
podman login rhel8/registry.redhat.io
# input user and pass
podman pull rhel8/registry.redhat.io/rsyslog
sudo su
echo pass

cd /var/log
mkdir journal
systemctl restart systemd-journald.service
cd journal
ls
exit

mkdir ~/containter-logserver
cp /var/log/ ~/contianer-logserver
podman run -d --name logserver -v /home/wallah/container-logserver/:/var/log/:Z rsyslog
podman ps

mkdir ~/.config/systemd/user
cd ~/.config/systemd/user
podman generate systemd logserver > container-logserver.service
# vim container-logserver.service
# WantedBy=default.target
sed -i "/^WantedBy/a = default.target #" container-logserver.service

systemctl --user daemon-reload
podman container ls
podman container stop logserver
systemctl --user enable --now container-logserver.service
loginctl enable-linger wallah
login list-users
init 6

# ssh wallah@192.168.1.101
podman container ls
