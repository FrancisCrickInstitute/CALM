#!/bin/bash
. ~/.bashrc

echo "Loading Anaconda"
ml Anaconda3/2023.03

# purge pip
pip cache purge

ml GCC
ml VirtualGL

# if conda hasn't been setup then uncomment the following to initialise
# conda init bash

# URL of the YAML file on the GitHub
yaml_url="https://raw.githubusercontent.com/FrancisCrickInstitute/CALM/napari/napari/napari-nemo-jan24.yml"

# folder to download the yaml file
download_folder="./tmp"

# check if the folder exists, and create it if it doesn't
if [ ! -d "$download_folder" ]; then
	mkdir -p "$download_folder"
	echo "Created folder: $download_folder"
else
	echo "Folder already exists: $download_folder"
fi

# download the yaml file
wget -O "$download_folder/napari-nemo-jan24.yml" "$yaml_url"

# check to see if download was successful
if [ $? -eq 0 ]; then
	echo "YAML file downloaded successfully"
else
	echo "Failed to download the YAML file - exiting"
	exit 1
fi

# check to see if the environment already exists
# specify path to the yaml file
yaml_file="$download_folder/napari-nemo-jan24.yml"

# check if the file exists
if [ ! -f "$yaml_file" ]; then
	echo "Error: YAML file not found"
	exit 1
fi

# Find the name of the environment
environment_name=$(grep "name:" "$yaml_file" | awk '{print $2}')

# check if the environment name is found in the YAML file
if [ -z "$environment_name" ]; then
	echo "Error: Environment name not found in YAML file"
	exit 1
fi

# check if the conda environment exists
if conda env list | grep -q "$environment_name"; then
	# Remove the conda env
	conda env remove --name "$environment_name" --yes
	echo "conda environment '$environment_name' removed"
else
	echo "conda environment '$environment_name' does not already exist"
fi

# remove all whitespace characters, tabs and newlines
echo "'$environment_name'"

# install dependencies using mamba and the downloaded yaml file

cd $download_folder
echo "$PWD"

mamba env create --file napari-nemo-jan24.yml

# check if the conda environment exists
if conda env list | grep -q "$environment_name"; then
	echo "conda environment '$environment_name' exists"
else
	echo "Error: conda environment '$environment_name' not found. Exiting"
	exit 1
fi

echo "Created environment"

# set up jupyter notebook kernels
# purge modules before activating env
ml purge

echo "Activating environment"
conda activate napari-nemo-jan24

python -m ipykernel install --user --name=napari-nemo-jan24

# clean up remove temp folder and yml file
rm -r tmp

echo "script completed"
