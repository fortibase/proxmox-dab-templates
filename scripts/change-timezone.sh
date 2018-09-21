#!/bin/bash

# Change timezone (echo to /etc/timezone doesn't work, and timedatectl set-timezone doesn't work in dab exec)

dab exec ln -fs /usr/share/zoneinfo/Europe/Istanbul /etc/localtime
dab exec dpkg-reconfigure --frontend noninteractive tzdata