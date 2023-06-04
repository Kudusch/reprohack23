#!/bin/bash

# set up
Rscript install_dependencies.r
Rscript get_material.r
Rscript install_dependencies.r

## attach LDA to the back of Preprocessing.R
mv R\ script Rscript
cp Rscript/Preprocessing.R Rscript/LDA2.R
cat Rscript/LDA.R >> Rscript/LDA2.R

## patch LDA2.R
sed -i '6 i rt <- read.csv("Data/Data.csv")$Abstract' Rscript/LDA2.R
sed -i '84 i write.csv(data_frame(k = n_topics, perplex = map_dbl(ap_lda_compare, perplexity)), "perplex.csv")' Rscript/LDA2.R
R CMD BATCH Rscript/LDA2.R

## get the artefacts
cp LDA2.Rout output/LDA2.Rout
cp Rplots.pdf output/Rplots.pdf
cp perplex.csv output/perplex.csv

## Run it to die

Rscript Rscript/Plots\ for\ Figures\ 2\,\ 3\,\ and\ 5.R
