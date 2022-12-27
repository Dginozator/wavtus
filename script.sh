#!/bin/bash
# user name: system_username
# postgresql user: test_pguser
# postgresql user password: pgiscool123
# postgresql DB name: testpgdb
# direstus email: a@a.com
# directus admin pass: directusiscool123
#
# Next can be generated with cat /proc/sys/kernel/random/uuid
# directus key: 785f1dbd-e3fc-4381-82d2-a3466bbf1097
# directus secret: d650376b-cf10-49d5-9634-dae8982d7590

sudo apt-cache search postgresql | grep postgresql
sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
sudo apt -y update
sudo apt-cache search postgresql | grep postgresql
sudo apt -y install postgresql-14
sudo apt install     ca-certificates     curl     gnupg     lsb-release
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo   "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
$(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update
sudo apt install docker-ce docker-ce-cli containerd.io docker-compose-plugin docker-compose
sudo usermod -aG docker system_username
sudo -u postgres psql -c "CREATE USER test_pguser WITH ENCRYPTED PASSWORD 'pgiscool123';"
sudo -u postgres createdb -T template0 testpgdb -O test_pguser

sudo nano /etc/postgresql/14/main/pg_hba.conf
sudo service postgresql restart

sudo docker run --restart=always --network host  -e KEY=785f1dbd-e3fc-4381-82d2-a3466bbf1097   -e SECRET=d650376b-cf10-49d5-9634-dae8982d7590   -e ADMIN_EMAIL=a@a.com -e ADMIN_PASSWORD="directusiscool123" -e DB_CLIENT="postgres" -e DB_HOST="localhost" -e DB_PORT="5432" -e DB_SSL="false" -e DB_DATABASE="testpgdb" -e DB_USER="test_pguser" -e DB_PASSWORD="pgiscool123" directus/directus

cd ~
mkdir weaviate
cd weaviate
curl -o docker-compose.yml "https://configuration.semi.technology/v2/docker-compose/docker-compose.yml?gpu_support=false&media_type=text&modules=modules&ner_module=false&qna_module=false&runtime=docker-compose&spellcheck_module=false&sum_module=false&text_module=text2vec-transformers&transformers_model=sentence-transformers-paraphrase-multilingual-MiniLM-L12-v2&weaviate_version=v1.15.1"

nano docker-compose.yml
sed -i 's/old-text/new-text/g' input.txt

cd /var/lib
sudo mkdir weaviate
cd ~/weaviate
docker-compose up -d