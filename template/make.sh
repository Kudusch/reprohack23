#!/bin/bash

# set up
Rscript install_dependencies.r
Rscript get_material.r
Rscript install_dependencies.r

## If you need python
# eval "$(pyenv init -)"
# pyenv global $PYTHON_VERSION
# pip config set global.index-url https://packagemanager.posit.co/pypi/$SNAPSHOT_DATE/simple
# pip install pipreqs jupyterlab notebook nbconvert
# ## If there are notebooks
# jupyter nbconvert *.ipynb --to script
# pipreqs --mode no-pin --force
# pip install -r requirements.txt
# pip freeze > /usr/local/src/output/requirements.txt
# python --version

## ADD THE BATCH EXECUTION CODE HERE
## e.g.

# Rscript -e "rmarkdown::render('repro.Rmd',
#             output_dir = '/usr/local/src/output')"
