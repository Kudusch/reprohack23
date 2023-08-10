#!/bin/bash

# set up

git init
git remote add origin https://github.com/kj2013/deliberative-politics
git fetch
git checkout a17bf992cf19bafd9f2cbc86f3713500c28a4574

apt-get install patch

## If you need python
eval "$(pyenv init -)"
pyenv global $PYTHON_VERSION
pip config set global.index-url https://packagemanager.posit.co/pypi/$SNAPSHOT_DATE/simple
pip install pipreqs jupyterlab notebook nbconvert
# ## If there are notebooks
cd notebooks
jupyter nbconvert *.ipynb --to python
pipreqs --mode no-pin --force
pip install -r requirements.txt
python --version

## External dependecies (declared implicitly)
python -m spacy download en_core_web_sm
python -m spacy download en_core_web_lg 
python -c "import nltk; nltk.download('averaged_perceptron_tagger')"

cp ../lexica/*.* ./
cp -r ../data ./
cp ../01.diff ./

patch < 01.diff
python '01 - Deliberation - Feature extraction.py'

## ADD THE BATCH EXECUTION CODE HERE
## e.g.

# Rscript -e "rmarkdown::render('repro.Rmd',
#             output_dir = '/usr/local/src/output')"
