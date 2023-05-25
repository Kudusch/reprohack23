#!/bin/bash

# recreate clean output folder
rm -r /usr/local/src/output/*

# set up
Rscript install_dependencies.r
Rscript get_material.r
Rscript install_dependencies.r

# chnages to get it to run
## correct wrong data path
sed -i 's|data/|../data/|g' code_for_reproduction/repro.Rmd

# run analysis
Rscript -e "rmarkdown::render('./code_for_reproduction/repro.Rmd',
            output_dir = '/usr/local/src/output')"

cp -r . ../output
