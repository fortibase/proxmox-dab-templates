#!/bin/bash

# Enables Firewall and http, https rules

dab exec ufw allow http
dab exec ufw allow https
dab exec ufw enable
