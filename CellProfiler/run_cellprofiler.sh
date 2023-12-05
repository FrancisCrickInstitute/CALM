#!/bin/bash



# Load anaconda and init
source ~/.bashrc
ml Anaconda3

#Load other modules
ml GCC
ml Java
#mamba init bash

#Load Virtual GL
ml VirtualGL

echo "Loaded modules"

# Activating environment
#mamba env list

conda activate cp426_nemo_v1
echo "Activating environment, and Launching CellProfiler, may take a minute"

vglrun cellprofiler