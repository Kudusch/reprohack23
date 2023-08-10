#!/bin/bash

# set up
Rscript install_dependencies.r
Rscript get_material.r
##Rscript install_dependencies.r

## If you need python
eval "$(pyenv init -)"
pyenv global $PYTHON_VERSION
pip config set global.index-url https://packagemanager.posit.co/pypi/$SNAPSHOT_DATE/simple
pip install pipreqs jupyterlab notebook nbconvert
## If there are notebooks
jupyter nbconvert *.ipynb --to python

sed -i 's/use corenlp lemma instead/#use core nlp lemma instead/' training\ lda\ and\ create\ dataset\ for\ human\ interpretation.py

pipreqs --mode no-pin --force
pip install -r requirements.txt
# python --version

## ADD THE BATCH EXECUTION CODE HERE

## Run to die (the earliest kill is the lack of stopword list)
## But the main problem is the lack of original data (in MongoDB)
## The computational environment is also underdescribed, e.g. Standford NLP

python training\ lda\ and\ create\ dataset\ for\ human\ interpretation.py

