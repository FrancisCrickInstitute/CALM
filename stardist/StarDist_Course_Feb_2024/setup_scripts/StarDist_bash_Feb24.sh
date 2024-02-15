#!/bin/bash
. ~/.bashrc
echo "Loading Anaconda"
ml Anaconda3/2023.09-0
# if conda hasn't been setup do conda init or source the following script.
# this modifies your bashrc by removing existing conda initializations and
# reinitializes with the version of the loaded module
conda deactivate
#source /camp/apps/eb/software/Anaconda/conda.env.sh 
echo "Creating environment"
mamba env create -f StarDist_Crick_Feb24.yml
ml purge 
conda activate StarDist_Crick_Feb24
echo "Installing csbdeep"
pip install csbdeep --no-deps
pip install numpy==1.18.5 --ignore-installed
echo "Installing stardist"
pip install stardist
echo "Installing remote ikernel"
pip install remote_ikernel
python -m ipykernel install --user --name=StarDist_Crick_Feb24
echo "Setting up juypter"
python3 -m remote_ikernel manage --add --kernel_cmd="ml purge && ml cuDNN/8.4.1.50-CUDA-11.7.0 && conda activate StarDist_Crick_Feb24 && ipython3 kernel -f {connection_file}" --name="StarDist_Crick_Feb24" --interface=local --workdir="~/"--language=python3
echo "Whoo hoo! I've finished installing!"
