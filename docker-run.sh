#!/usr/bin/env bash

docker stop rplots
docker rm rplots

docker run -P -d \
           --name rplots \
           -v /Users/bastian/Documents/rails/snpr/public/data/plot_data:/plot_data/ \
           -w /home/plots/ \
           growthplots

docker exec rplots Rscript createPlots.R /plot_data/
