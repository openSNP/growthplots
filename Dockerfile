FROM rocker/hadleyverse

RUN git clone https://github.com/openSNP/growthplots /home/plots/
WORKDIR /home/plots/
