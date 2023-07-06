#!/bin/bash

# set up
# Rscript install_dependencies.r
# Rscript get_material.r
# Rscript install_dependencies.r

git init
git remote add origin https://github.com/Christoph/MultilingualTextAnalysis
git fetch
git checkout 6ff36427203738c7980999bfd38409434a221fb7

## If you need python
eval "$(pyenv init -)"
pyenv global $PYTHON_VERSION
pip config set global.index-url https://packagemanager.posit.co/pypi/$SNAPSHOT_DATE/simple
pip install pipreqs jupyterlab notebook nbconvert
## If there are notebooks
##jupyter nbconvert *.ipynb --to script
pipreqs --mode no-pin --force
pip install -r requirements.txt
pip freeze > /usr/local/src/output/requirements.txt
##python --version

## status 1
python classifier_evaluation.py
