#!/bin/bash

git init
git remote add origin https://github.com/chainsawriot/ots
git fetch
git checkout 061dab50272ddfe74363c6212e5f6a1da658ff68

# set up
# The authors give specific instructions on the environment, which are incomplete though.
# The package ggridges is missing (maybe others as well).
Rscript install_dependencies.r

## If you need python
eval "$(pyenv init -)"
pyenv global $PYTHON_VERSION
pip config set global.index-url https://packagemanager.posit.co/pypi/$SNAPSHOT_DATE/simple

## ADD THE BATCH EXECUTION CODE HERE

####################################
## Prerequisites (as per authors' instructions)
pip3 install doit

Rscript install_dependencies_from_readme.R

## We modify the following instructions because we would like to use the archived OSF materials

# Rscript -e 'install.packages("osfr") 
# require(osfr) 
# require(tidyverse) 
# require(stringr) 
# osf_retrieve_node("https://osf.io/utxs5/") %>% osf_ls_files  -> utxs5_files 
# utxs5_files[str_detect(utxs5_files$name, "RDS$|csv$"), ] %>% osf_download(path = here::here("data/raw"), conflicts = "overwrite")'

Rscript get_materials.R

## Reproduce
# a file is missing, hence phack_pres.R errors. to make the script continue, I ignore errors 
doit passphraise="geheim" || true

cp appendices.rmd.diff report
cd report

# results from phack_pres.R are needed for the appendix. Without appendix, the pdf can be compiled
sed -i '/appendix          : "appendices.rmd"/d' report.rmd
patch < appendices.rmd.diff

make pdf
make ccr
make appendix

cd ..
cp -r report /usr/local/src/output
