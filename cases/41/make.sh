#!/bin/bash

# set up
#Rscript install_dependencies.r
#Rscript get_material.r
#Rscript install_dependencies.r

git init
git remote add origin https://github.com/SPraet/issue_communication
git fetch
git checkout 647768bf0ac5dfb68109fed36a09249948b455e7

## Can't run the code in Data, the API cost USD 5000 per month

cd Data

eval "$(pyenv init -)"
pyenv global $PYTHON_VERSION
pip config set global.index-url https://packagemanager.posit.co/pypi/$SNAPSHOT_DATE/simple
pip install pipreqs jupyterlab notebook nbconvert
## If there are notebooks
jupyter nbconvert *.ipynb --to python
pipreqs --mode no-pin --force
pip install -r requirements.txt
python --version

## Status 1
python json_to_excel.py
