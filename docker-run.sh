#!/usr/bin/env bash

docker stop rplots
docker rm rplots

docker run --name rplots \
           -v $1:/plot_data/ \
           -w /home/ \
           growthplots
