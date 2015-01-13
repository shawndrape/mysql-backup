Downloads a backup of a running mysql container database into the current directory (or another directory of your choice)

## Usage:

docker run --link *running-mysql-container*:mysql -v $(pwd):/backup -e "MYSQL_DATABASE_NAME=*database-name*" -e "BACKUP_FILENAME=*backup-filename*" --rm shawndrape/mysql-backup:5.5

### Optional parameters:

BACKUP_FILENAME: Defaults to "databaseBackup.sql" if not specified