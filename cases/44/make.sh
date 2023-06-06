#!/bin/bash

# set up
#Rscript install_dependencies.r
##Rscript get_material.r

## git clone

git init
git remote add origin https://github.com/stefangeiss/statistical_power
git fetch
git checkout fe1b78dbeaecce07585e53beea97f76fa433f20d

apt install patch
patch < Simulation.R.diff

Rscript install_dependencies.r

Rscript -e "repo <- paste0('https://packagemanager.posit.co/cran/', Sys.getenv('SNAPSHOT_DATE')); 
options(repos = c(REPO_NAME = repo)); install.packages('svglite')"

cat DataAnalysis.R >> Simulation.R
R CMD BATCH Simulation.R

cp *.Rout /usr/local/src/output
cp *.svg /usr/local/src/output
cp *.pdf /usr/local/src/output
