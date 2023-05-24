#!/bin/bash

# set up
Rscript install_dependencies.r
Rscript get_material.r
Rscript install_dependencies.r


# run analysis
Rscript -e "rmarkdown::render('./code_for_reproduction/repro.Rmd')"

cp -r . ../output
