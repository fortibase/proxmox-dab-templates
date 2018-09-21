#!/bin/bash

# Enables Firewall and fail2ban

dab install fail2ban
dab exec ufw allow ssh
dab exec ufw enable
