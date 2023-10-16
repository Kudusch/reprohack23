#!/bin/bash

apt-get install patch -y

# set up
Rscript install_dependencies.r

Rscript get_material.r

unzip age-gender.zip

## we tried, but packrat doesn't work
## cd age-gender
## Rscript -e "packrat::restore()"

## we also tried to convert it to renv; doesn't work either.
## Moral of the story: Don't mess with MASS

rm -rf age-gender/packrat

## using our scanning instead
Rscript install_dependencies.r

## The GH version of easystats as per SNAPSHOT_DATE
Rscript -e "options(repos = c(REPO_NAME = paste0(\"https://packagemanager.posit.co/cran/\", as.Date(Sys.getenv(\"SNAPSHOT_DATE\"))))); remotes::install_github(\"easystats/easystats@4d728f88171830cc51d1730686e525d2d438db9c\")"

## To be fair, R.utils is in the packrat
Rscript -e "options(repos = c(REPO_NAME = paste0(\"https://packagemanager.posit.co/cran/\", as.Date(Sys.getenv(\"SNAPSHOT_DATE\"))))); install.packages(\"R.utils\")"

cp 2.diff age-gender/2.diff

cd age-gender/
patch < 2.diff
R CMD BATCH 2_analysis.R

cd ..
cp -r age-gender /usr/local/src/output

# Part 2
unzip face.zip
cp 3.diff face/3.diff
cp 4.diff face/4.diff
cd face

# run included container
apt-get install -y docker.io

patch < 3.diff
patch < 4.diff
DOCKER_BUILDKIT=0 docker build -t 20-repro_4-2-face-image -f face-gpu.Dockerfile .
docker run --gpus all --name 20-repro_4-2-face 20-repro_4-2-face-image

cp -r /usr/local/src/input/face /usr/local/src/output/
