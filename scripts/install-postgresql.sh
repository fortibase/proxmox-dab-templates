#!/bin/bash

# Installs requested version of PostgreSQL for requested Ubuntu version. Allows connection to PG from anywhere.

VERSION=$1
BASEDIR=$(dab basedir)
UBUNTUVERSION=$(dab exec lsb_release -c -s)


echo $UBUNTUVERSION
echo "deb http://apt.postgresql.org/pub/repos/apt/ $UBUNTUVERSION-pgdg main" | tee $BASEDIR/etc/apt/sources.list.d/pgdg.list
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | dab exec apt-key add -
dab install postgresql-$VERSION postgresql-contrib-$VERSION libpq-dev postgresql-server-dev-$VERSION
printf "local all postgres peer\nlocal all all md5\nhost all all 192.168.0.0/16 md5" | tee $BASEDIR/etc/postgresql/$VERSION/main/pg_hba.conf
sed -i "s/^#listen_addresses = 'localhost'/listen_addresses = '*'\t/" $BASEDIR/etc/postgresql/$VERSION/main/postgresql.conf