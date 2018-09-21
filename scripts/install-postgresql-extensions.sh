#!/bin/bash


# Installs PostgreSQL Extensions.

BASEDIR=$(dab basedir)

mkdir $BASEDIR/pg-extensions

wget https://github.com/ozum/pg_datatype_password/archive/master.zip
mv master.zip $BASEDIR/pg-extensions/
unzip $BASEDIR/pg-extensions/master.zip -d $BASEDIR/pg-extensions/
rm $BASEDIR/pg-extensions/master.zip

wget https://github.com/ozum/boolean_cascaded/archive/master.zip
mv master.zip $BASEDIR/pg-extensions/
unzip $BASEDIR/pg-extensions/master.zip -d $BASEDIR/pg-extensions/
rm $BASEDIR/pg-extensions/master.zip

dab exec make -C /pg-extensions/pg_datatype_password-master
dab exec make install -C /pg-extensions/pg_datatype_password-master

dab exec make -C /pg-extensions/boolean_cascaded-master
dab exec make install -C /pg-extensions/boolean_cascaded-master

rm -rf $BASEDIR/pg-extensions
