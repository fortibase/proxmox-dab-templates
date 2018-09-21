#!/bin/bash

# Allows unattended upgardes (security and update), and allows reboot.

BASEDIR=$(dab basedir)

dab install unattended-upgrades update-notifier-common
sed -i '/"$${distro_id}:$${distro_codename}-updates";/s/^\/\///' $BASEDIR/etc/apt/apt.conf.d/50unattended-upgrades
sed -i '/Unattended-Upgrade::Automatic-Reboot-Time/s/^\/\///' $BASEDIR/etc/apt/apt.conf.d/50unattended-upgrades
sed -i '/Unattended-Upgrade::Automatic-Reboot "false"/s/^\/\///' $BASEDIR/etc/apt/apt.conf.d/50unattended-upgrades
sed -i '/Unattended-Upgrade::Automatic-Reboot "false"/s/"false"/"true"/' $BASEDIR/etc/apt/apt.conf.d/50unattended-upgrades