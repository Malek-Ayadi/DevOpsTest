#!/usr/bin/env bash

BKP_DIR=/backup

# Init backup settings, default to 6 monthly, 4 weekly and the last 7 days
[ ! -z "${BKP_KEEP_MONTHLY##*[!0-9]*}" ] || BKP_KEEP_MONTHLY=6
[ ! -z "${BKP_KEEP_WEEKLY##*[!0-9]*}" ] || BKP_KEEP_WEEKLY=4
[ ! -z "${BKP_KEEP_DAYS##*[!0-9]*}" ] || BKP_KEEP_DAYS=7

DAY_OF_MONTH=$(date '+%d')
DAY_OF_WEEK_RAW=$(date '+%w')
DAY_OF_WEEK=$((DAY_OF_WEEK_RAW + 1))
MONTH=$(date '+%m')
YEAR=$(date '+%Y')
NOW=$(date '+%s')

cd $BKP_DIR;
SQLFILE="$(date '+%Y-%m-%d-%H%M')-$MYSQL_DATABASE.sql"

echo "Creating dump $SQLFILE"
MYSQL_PWD=$MYSQL_PASSWORD mysqldump -u$MYSQL_USER --single-transaction --quick --lock-tables=false --no-tablespaces $MYSQL_DATABASE > $SQLFILE

echo "Removing old files ..."
