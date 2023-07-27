#!/bin/bash

# set up
Rscript install_dependencies.r
Rscript get_material.r
Rscript install_dependencies.r

cd main

## If you need python
eval "$(pyenv init -)"
pyenv global $PYTHON_VERSION
pip config set global.index-url https://packagemanager.posit.co/pypi/$SNAPSHOT_DATE/simple
pip install pipreqs jupyterlab notebook nbconvert
## If there are notebooks
jupyter nbconvert *.ipynb --to python
pipreqs --mode no-pin --force
pip install -r requirements.txt
##pip freeze > /usr/local/src/output/requirements.txt
##python --version

## Undeclared dependency
Rscript -e "install.packages('formatR')"

## "Minor editing"
mv data.csv ccr_data_share.csv
mkdir plots

## code editing
sed -i 's/setwd("YOUR PATH TO DATA")//' models_R_share.Rmd 

## ADD THE BATCH EXECUTION CODE HERE

jupyter nbconvert --execute --to notebook analysis_osf.ipynb
cp analysis_osf.nbconvert.ipynb /usr/local/src/output/

Rscript -e "rmarkdown::render('models_R_share.Rmd',
            output_dir = '/usr/local/src/output')" 2> /usr/local/src/output/rendering_trace.txt
