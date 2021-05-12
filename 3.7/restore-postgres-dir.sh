#!/bin/bash -ex

# check if first of the backup files exists and restore 
if [ -f $BACKUP_DIR/pg12-nominatim.tgz_aa ]; then
    # strip-componets will remove 5 levels from the path, so this prefix will be removed: /var/lib/postgresql/12/main
    cat $BACKUP_DIR/pg12-nominatim.tgz_* | tar xzv --directory $POSTGRES_DATA_DIR --strip-components=5

    # change ownership to postgres
    chown -R postgres:postgres $POSTGRES_DATA_DIR
fi
