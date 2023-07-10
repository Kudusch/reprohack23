#!/bin/bash

# set up
#Rscript install_dependencies.r
#Rscript get_material.r

git init
git remote add origin https://github.com/markusneumann/BodyLanguage
git fetch
git checkout 7f47fd959f72275d9a288967aaac8ef073bc005b

sed -i 's|combined_fr_pd/|combined_fr_pd|' code/04_measure_assertiveness.R

Rscript install_dependencies.r

## If you need python
eval "$(pyenv init -)"
pyenv global $PYTHON_VERSION
pip config set global.index-url https://packagemanager.posit.co/pypi/$SNAPSHOT_DATE/simple
pip install gdown

gdown https://drive.google.com/file/d/10iEYrEz1A12mmvXL02wn2Si-PTRP8h5-/view?usp=sharing --fuzzy -O results/combined_fr_pd.zip
unzip results/combined_fr_pd.zip -d results

cd code
R CMD BATCH 04_measure_assertiveness.R
R CMD BATCH 05_analysis.R
R CMD BATCH figure2.R

cd ..

cp -r code /usr/local/src/output
cp -r tables /usr/local/src/output
cp -r figures /usr/local/src/output
cp -r data /usr/local/src/output
cp results/dominance/convhull_on_all_data.rdata /usr/local/src/output

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
