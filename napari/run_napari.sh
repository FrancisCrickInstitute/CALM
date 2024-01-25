#!/bin/bash

# load anaconda
source ~/.bashrc
ml Anaconda3

# load other modules
ml GCC
ml VirtualGL

# activate environment
echo "activating environment"
conda activate napari-nemo-jan24

# loading napari
echo "Loading napari"
vglrun napari
