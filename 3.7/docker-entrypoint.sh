#!/bin/bash -ex

stopServices() {
  echo Stopping services ...
  service postgresql stop
}
trap stopServices INT TERM

/app/config.sh

IMPORT_FINISHED=$POSTGRES_DATA_DIR/import-finished

# first try to restore from a backup
if [ ! -f ${IMPORT_FINISHED} ]; then
  /app/restore-postgres-dir.sh
fi

# if backup was not found, prepare a backup
if [ ! -f ${IMPORT_FINISHED} ]; then
  /app/init.sh
  touch ${IMPORT_FINISHED}
  /app/backup-postgres-dir.sh
fi

cd ${PROJECT_DIR} && nominatim refresh --website

service postgresql start

# Run Apache in the foreground
/usr/sbin/apache2ctl -D FOREGROUND
