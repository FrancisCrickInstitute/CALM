#!/bin/bash

# load anaconda and init
source ~/.bashrc
ml Anaconda3

# load other modules
conda init bash
ml VirtualGL

# activate environment
echo "activating environment"
conda activate napari-env2-nemo

# loading napari
echo "Loading napari"
vglrun napari