#!/bin/bash

# Create locales and update system locale settings

dab exec locale-gen tr_TR
dab exec locale-gen tr_TR.utf8
dab exec locale-gen en_US.utf8
dab exec update-locale LANG=en_US.UTF-8 LC_MESSAGES=POSIX
