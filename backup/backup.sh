#!/usr/bin/env bash

# source: https://help.passbolt.com/hosting/backup/from-source.html
# NOTE: passbolt is fully configured via env vars, so no need to backup any PHP files

set -eo pipefail

############
# SETTINGS #
############

# current timestamp
TIMESTAMP="$(date +%Y-%m-%d_%H-%M-%S)"

# folder in which backup should be stored
FOLDER="./$TIMESTAMP"

# the name of the fly.io app that contains the mysql database for passbolt
APP_MYSQL="mysql-regens-unite"

# the name of the fly.io app that contains the passbolt instance
APP_PASSBOLT="passbolt-regens-unite"

# the location of passbolt's public key on the server
PASSBOLT_GPG_SERVER_KEY_PUBLIC="/etc/passbolt/gpg/serverkey.asc"

# the location of passbolt's private key on the server
PASSBOLT_GPG_SERVER_KEY_PRIVATE="/etc/passbolt/gpg/serverkey_private.asc"

# the mysql user that should be used to initiate the database backup
MYSQL_USER="root"

# the name of the mysql database that should be backed up
MYSQL_DATABASE="passbolt_1"


######################
# PRINT CURRENT USER #
######################

echo -n "logged in as: "
fly auth whoami


########################
# CREATE BACKUP FOLDER #
########################

mkdir -p "$FOLDER"


########################
# DOWNLOAD SERVER KEYS #
########################

fly sftp get "$PASSBOLT_GPG_SERVER_KEY_PUBLIC" "$FOLDER/serverkey.asc" --app "$APP_PASSBOLT"
fly sftp get "$PASSBOLT_GPG_SERVER_KEY_PRIVATE" "$FOLDER/serverkey_private.asc" --app "$APP_PASSBOLT"


##########################
# DOWNLOAD DATABASE DUMP #
##########################

fly ssh console --app "$APP_MYSQL" --command "mysqldump -u $MYSQL_USER -p $MYSQL_DATABASE --result-file=/tmp/db-dump-$TIMESTAMP.sql"
fly sftp get "/tmp/db-dump-$TIMESTAMP.sql" "$FOLDER/db-dump-$TIMESTAMP.sql" --app "$APP_MYSQL"