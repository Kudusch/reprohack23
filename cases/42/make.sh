#!/bin/bash

git clone https://github.com/chainsawriot/ots/
cd ots

# set up
# The authors give specific instructions on the environment, which are incomplete though.
# The package ggridges is missing (maybe others as well).
Rscript ../install_dependencies.r
#Rscript get_material.r
#Rscript install_dependencies.r

## If you need python
eval "$(pyenv init -)"
pyenv global $PYTHON_VERSION
pip config set global.index-url https://packagemanager.posit.co/pypi/$SNAPSHOT_DATE/simple
pip install pipreqs jupyterlab notebook nbconvert
# ## If there are notebooks
# jupyter nbconvert *.ipynb --to python
# pipreqs --mode no-pin --force
# pip install -r requirements.txt
# python --version

## ADD THE BATCH EXECUTION CODE HERE

####################################
## Prerequisites (as per authors' instructions)
pip3 install doit

Rscript -e 'install.packages(c("rvest", "tidyverse", "lubridate", "lmtest", "zoo", "corrplot", "rio", "here", "rmarkdown", "stringr"))'
Rscript -e 'install.packages("devtools"); devtools::install_github("crsh/papaja")'
Rscript -e 'install.packages("osfr") 
require(osfr) 
require(tidyverse) 
require(stringr) 
osf_retrieve_node("https://osf.io/utxs5/") %>% osf_ls_files  -> utxs5_files 
utxs5_files[str_detect(utxs5_files$name, "RDS$|csv$"), ] %>% osf_download(path = here::here("data/raw"), conflicts = "overwrite")'

## Reproduce
# a file is missing, hence phack_pres.R errors. to make the script continue, I ignore errors 
doit passphraise="geheim" || true

cd report

# results from phack_pres.R are needed for the appendix. Without appendix, the pdf can be compiled
sed -i '/appendix          : "appendices.rmd"/d' report.rmd

make pdf
make ccr
# make appendix

cd ..
cp -r report /usr/local/src/output
