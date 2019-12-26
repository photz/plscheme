#!/usr/bin/env bash

docker build -t plscheme .

CONTAINER_ID=`docker run -d --rm -p 5432:5432 --name plscheme plscheme`

docker run \
       -i \
       -t \
       --rm \
       --network container:plscheme \
       --name pgtap \
       -v $(pwd)/test/:/test \
       -e TESTS=/test/*.sql \
       -e HOST=localhost \
       -e DATABASE=postgres \
       -e USER=postgres \
       -e PASSWORD=postgres \
       hbpmip/pgtap

docker stop container plscheme
