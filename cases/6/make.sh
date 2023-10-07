#!/bin/bash

git init
git remote add origin https://github.com/Tarlanc/ABM_PanelWaves.git
git fetch
git checkout 766ac322af3b10023919ba0bd8d499208e76f8f3

Rscript install_dependencies.r

eval "$(pyenv init -)"
pyenv global $PYTHON_VERSION
pip config set global.index-url https://packagemanager.posit.co/pypi/$SNAPSHOT_DATE/simple

## The Python actually does not need pypi / pip.
## But the code is quite slow; we need to run them in parallel
apt-get update; apt-get install parallel patch -y
parallel < cmds1.sh

## do all visualization tasks

cp BS_W1.diff Simulation_BS_W1; cd Simulation_BS_W1; patch < BS_W1.diff; R CMD BATCH Visualize_Progress_bs.R; cd ..
cp BS_W2.diff Simulation_BS_W2; cd Simulation_BS_W2; patch < BS_W2.diff; R CMD BATCH Visualize_Progress_bs2.R; cd ..
cp Integ_W1.diff Simulation_Integ_W1; cd Simulation_Integ_W1; patch < Integ_W1.diff; R CMD BATCH Visualize_Progress_within.R; cd ..
cp Integ_W2.diff Simulation_Integ_W2; cd Simulation_Integ_W2; patch < Integ_W2.diff; R CMD BATCH Visualize_Progress_within_w2.R; cd ..
cp Naive_W1.diff Simulation_Naive_W1; cd Simulation_Naive_W1; patch < Naive_W1.diff; R CMD BATCH Visualize_Progress_complete.R; cd ..

## For simplicity, just copy all things
cp -r /usr/local/src/input /usr/local/src/output
