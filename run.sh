#!/bin/bash
set -e

# Check for the environment variables we expect
# MYSQL_PORT_3306_TCP_ADDR, MYSQL_PORT_3306_TCP_PORT, MYSQL_ENV_MYSQL_ROOT_PASSWORD, MYSQL_DATABASE_NAME

if [ -z "$MYSQL_PORT_3306_TCP" ]; then
	echo >&2 'error: missing MYSQL_PORT_3306_TCP environment variable'
	echo >&2 '  Did you forget to --link some_mysql_container:mysql ?'
	exit 1
fi

if [ -z "$MYSQL_DATABASE_NAME" ]; then
	echo >&2 'error: missing MYSQL_DATABASE_NAME environment variable'
	echo >&2 '  Please specify the database to backup by using -e "MYSQL_DATABASE_NAME=database_name" during run'
	exit 1
fi

if [ ! -d "/backup" ]; then
	echo >&2 'error: unable to find "/backup" directory'
	echo >&2 '  Please ensure you have mounted a volume from the host to "/backup". Eg. -v $(pwd):/backup'
	exit 1
fi

if [ ! -z "$BACKUP_FILENAME" ]; then
	: ${BACKUP_LOCATION:="/backup/"$BACKUP_FILENAME}
else
	: ${BACKUP_LOCATION:="/backup/databaseBackup.sql"}
fi

exec mysqldump -h"$MYSQL_PORT_3306_TCP_ADDR" -P"$MYSQL_PORT_3306_TCP_PORT" -uroot -p"$MYSQL_ENV_MYSQL_ROOT_PASSWORD" "$MYSQL_DATABASE_NAME" > $BACKUP_LOCATION