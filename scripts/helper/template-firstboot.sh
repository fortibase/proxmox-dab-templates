#!/bin/bash

# Runs as a first boot script, and executes user provided boot script.

#ADMINPASS=$(perl -e 'print crypt("admin", "change-password-on-first-boot")')

# Create admin user with same password as root user's password. Add admin user to sudoers.
ROOTPASS=`sudo grep -o 'root:[^:]*' /etc/shadow | cut -c6-`;
sudo useradd -m -p "$ROOTPASS" -s /bin/bash admin
sudo usermod -aG sudo admin

# Add admin user public key for ssh
mkdir -p /home/admin/.ssh && touch /home/admin/.ssh/authorized_keys && chmod -R go= /home/admin/.ssh && echo ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDrnEa6NJBLUnZvX0au6IWC+wq8qrz8g96nSEGFwOUiZPJLXZX5hu+a4FYudUbzJEo9nmL+cC6Bd5/8di/2jnNSbkOWV587YptcDOt0m/dYVV0xpsCjF8eISLvp1rLeUrSK4iWJ1n3G24HqkLdwC1p3l2L6AwKXtvzgnHLdE+gX4acIVWfN5S6PH/6rZ4NtCF64EBQ5go5JJMgoeGxMSi95mUgIpmOgxz1fgUC57VdKcUAtZ0UXFmC257I+PP3hcbKvYcix5P66IZ7z/fQ2tEdpmkvWNPArUcew5d87mpwj3F0MVBO+R1QcDthBE0sbQetCi2MP3oEOTr878vw+rEWF ozum@Ozums-MacBook-Pro.local >> /home/admin/.ssh/authorized_keys && chown -R admin:admin /home/admin/.ssh

if [ -e "/usr/local/bin/template-firstboot-script.sh" ]; then
    /usr/local/bin/template-firstboot-script.sh
    rm /usr/local/bin/template-firstboot-script.sh
fi

systemctl disable template-firstboot.service
rm /var/log/template-firstboot.log
