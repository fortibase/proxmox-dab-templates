#!/bin/bash

# If there is a firstboot.sh file available in dab.conf's directory. Copies necessary scripts and files to template and
# registers a service, which executes script on the first boot.

BASEDIR=$(dab basedir)

cp ../scripts/helper/template-firstboot.service $BASEDIR/etc/systemd/system/
dab exec chmod 644 /etc/systemd/system/template-firstboot.service

cp ../scripts/helper/template-firstboot.sh $BASEDIR/usr/local/bin/
dab exec chmod 744 /usr/local/bin/template-firstboot.sh

if [ -e "firstboot.sh" ]; then
    cp firstboot.sh $BASEDIR/usr/local/bin/template-firstboot-script.sh
    dab exec chmod 744 /usr/local/bin/template-firstboot-script.sh
fi

touch $BASEDIR/var/log/template-firstboot.log
dab exec systemctl enable template-firstboot.service


