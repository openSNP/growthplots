# growthplots
Plotting our growth over time.

## createPlots.R
pass the folder where the csvs are located as single

`Rscript createPlots.R /here/are/our/plots/`

## Dockerfile
Basically just installs this repository in the hadleyverse image

## docker-run.sh
run the docker container created from the Dockerfile. Pass the path of where your data resides to it. 
