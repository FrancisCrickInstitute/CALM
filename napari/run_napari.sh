#!/bin/bash

# load anaconda and init
source ~/.bashrc
ml Anaconda3

# load other modules
ml GCC
ml VirtualGL
conda init bash
echo "loaded modules"

# activate environment
conda deactivate
echo "activating environment"
conda activate napari-nemo-jan24

# loading napari
echo "Loading napari"
vglrun napari
