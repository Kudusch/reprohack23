#!/bin/bash

# set up
Rscript install_dependencies.r
Rscript get_material.r
Rscript install_dependencies.r

## ADD THE BATCH EXECUTION CODE HERE
## e.g.

# Rscript -e "rmarkdown::render('repro.Rmd',
#             output_dir = '/usr/local/src/output')"
