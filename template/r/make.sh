#!/bin/bash

# set up
Rscript install_dependencies.r
Rscript get_material.r
Rscript install_dependencies.r

## ADD THE BATCH EXECUTION CODE HERE
## e.g.

# sed -i 's|data/|../data/|g' code_for_reproduction/repro.Rmd
# Rscript -e "rmarkdown::render('./code_for_reproduction/repro.Rmd',
#             output_dir = '/usr/local/src/output')"
