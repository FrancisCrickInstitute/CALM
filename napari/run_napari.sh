#!/bin/bash

# load anaconda and other modules
source ~/.bashrc

# load other modules
ml GCC
ml VirtualGL
echo "Loaded modules"

# activate env
conda deactivate
echo "Activating environment"
conda activate napari-nemo-jan24

# loading napari
echo "Loading napari"
vglrun napari
