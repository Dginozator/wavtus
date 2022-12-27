#!/usr/bin/env bash

SYSTEM_USERNAME="system_username"
POSTGRESQL_USER="test_pguser"
POSTGRESQL_USER_PASSWORD="pgiscool123"
POSTGRESQL_DB_NAME="testpgdb"
DIRESTUS_EMAIL="a@a.com"
DIRECTUS_ADMIN_PASS="directusiscool123"

# Next can be generated with cat /proc/sys/kernel/random/uuid
DIRECTUS_KEY="785f1dbd-e3fc-4381-82d2-a3466bbf1097"
DIRECTUS_SECRET="d650376b-cf10-49d5-9634-dae8982d7590"

sudo apt-cache search postgresql | grep postgresql
sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
sudo apt -y update
sudo apt-cache search postgresql | grep postgresql
sudo apt -y install postgresql-14 ca-certificates     curl     gnupg     lsb-release
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo   "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
$(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update
sudo apt -y install docker-ce docker-ce-cli containerd.io docker-compose-plugin docker-compose
sudo usermod -aG docker $SYSTEM_USERNAME
sudo -u postgres psql -c "CREATE USER $POSTGRESQL_USER WITH ENCRYPTED PASSWORD '$POSTGRESQL_USER_PASSWORD';"
sudo -u postgres createdb -T template0 $POSTGRESQL_DB_NAME -O $POSTGRESQL_USER

sudo service postgresql restart

sudo docker run --restart=always --network host  -e KEY=$DIRECTUS_KEY   -e SECRET=$DIRECTUS_SECRET   -e ADMIN_EMAIL=$DIRESTUS_EMAIL -e ADMIN_PASSWORD="$DIRECTUS_ADMIN_PASS" -e DB_CLIENT="postgres" -e DB_HOST="localhost" -e DB_PORT="5432" -e DB_SSL="false" -e DB_DATABASE="$POSTGRESQL_DB_NAME" -e DB_USER="$POSTGRESQL_USER" -e DB_PASSWORD="$POSTGRESQL_USER_PASSWORD" directus/directus

cd "$(dirname "$0")"
cd weaviate
sudo docker-compose up -d