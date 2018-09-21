#!/bin/bash

# Disable disable password login for all (only public ssh key)

BASEDIR=$(dab basedir)
sed -i '/#PasswordAuthentication yes/s/#PasswordAuthentication yes/PasswordAuthentication no/' ${BASEDIR}/etc/ssh/sshd_config
