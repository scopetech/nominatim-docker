#!/bin/bash -ex

# remove previous backups
rm -rf $BACKUP_DIR/*

# Compress directory $POSTGRES_DATA_DIR and store the file(s) it in $BACKUP_DIR directory
tar czv $POSTGRES_DATA_DIR/* | split -b 1024MiB - $BACKUP_DIR/pg12-nominatim.tgz_
