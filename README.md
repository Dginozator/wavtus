# Wavtus
Weaviate + Directus = Wavtus

It's a bash script that deploys three technologies on the same server:
- [PostgreSQL](https://www.postgresql.org/)
- [Directus](https://directus.io/)
- [Weaviate](https://weaviate.io/)

This stack allows you to quickly solve data storage issues and provides the possibility of semantic data analysis.

## Stack features
- PostgreSQL
  - backups with PostgreSQL
- Directus
  - beautiful and convinient admin panel
  - REST and GraphQL API
  - flexible access settings for different users
- Weaviate
  - semantic search
  - simple read and write data with Python, NodeJS
  - objects like a vectors, moreover semantic similarity is expressed in closer vectors.

## How to use
It's drammatically simple.

1. Install git, if not yet.
2. `git clone https://github.com/Dginozator/wavtus`
3. Go to wavtus directory.
4. `bash -x script.sh`

Now, [your_ip]:8055 - directus, [your_ip]:8080 - weaviate. Have fun!