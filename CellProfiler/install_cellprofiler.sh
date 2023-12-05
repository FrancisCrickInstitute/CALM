#!/bin/bash

# URL of the YAML file on GitHub
yaml_url="https://raw.githubusercontent.com/FrancisCrickInstitute/CALM/master/CellProfiler/cp_426.yml"

# Folder to download the YAML file
download_folder="./tmp"

# Check if the folder exists, and create it if it doesn't
if [ ! -d "$download_folder" ]; then
    mkdir -p "$download_folder"
    echo "Created folder: $download_folder"
else
    echo "Folder already exists: $download_folder"
fi

# Download the YAML file
wget -O "$download_folder/cp_426.yml" "$yaml_url"

# Check if the download was successful
if [ $? -eq 0 ]; then
    echo "YAML file downloaded successfully."
else
    echo "Failed to download the YAML file. Exiting."
    exit 1
fi


# Load GCC module
ml GCC

# Load Java module
ml Java
echo "Loaded modules"

# Install dependencies using mamba and the downloaded yml file
cd $download_folder
echo "$PWD"

mamba env create --file cp_426.yml

echo "Created Environment"

# Clean up: remove the downloaded YAML file
#rm "$download_folder/cp_426.yml"

echo "Script completed"