#!/bin/bash


# remove previous containers and network if exist

docker rm -f db app
docker volume rm gutendex-db
docker network rm gutendex-db


# create a volume, network and container fo Postgres database

docker volume create gutendex-db
docker network create gutendex-db
docker run -d --name db -v gutendex-db:/var/lib/postgresql/data -e POSTGRES_PASSWORD=gutendex -e POSTGRES_USER=gutendex -e POSTGRES_DB=gutendex --network gutendex-db postgres:14-alpine

# create container to run scripts that populates the database

docker run -d -it --name app --network gutendex-db python:3.9 bash
docker cp ./project app:/project
docker cp ./populate.sh app:/populate.sh
docker exec -it app ./populate.sh


# remove all the containers and network, keep the volume with database

docker rm -f db app
docker volume rm gutendex-db
docker network rm gutendex-db


docker compose up -d
