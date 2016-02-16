#!/usr/bin/env bash

docker stop rplots
docker rm rplots

docker run -P -d \
           --name rplots \
           -v $1:/plot_data/ \
           -w /home/plots/ \
           growthplots

docker exec rplots Rscript createPlots.R /plot_data/
