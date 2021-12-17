#! /bin/bash
#
# init-nextcloud-db.sh
# Copyright (C) 2021 luominghao <luominghao@live.com>
#
# Distributed under terms of the MIT license.
#
set -e

USERNAME="nextcloud"
DATABASE="nextcloud"

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    CREATE USER $USERNAME;
    CREATE DATABASE $DATABASE;
    GRANT ALL PRIVILEGES ON DATABASE $DATABASE TO $USERNAME;
EOSQL
