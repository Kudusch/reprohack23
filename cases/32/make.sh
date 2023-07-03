#!/bin/bash

# set up
git init
git remote add origin https://github.com/vriezer/sentiment
git fetch
git checkout ed5bd12a590b06e9a32058fe2eec57f38cd3f1e2

Rscript install_dependencies.r

unzip Docs.zip

mkdir Data ## undocumented

## Code execution
Rscript 01_data_processing.R
bash 02_glove.sh
Rscript 03_dictionary_generation.R
##04 hardcoded the plan; and multisession is dep
sed -i 's/multiprocess/multicore/' 04_sentiment_validation.R
Rscript 04_sentiment_validation.R
Rscript 05_sentiment_scoring.R

cp -r Data /usr/local/src/output
