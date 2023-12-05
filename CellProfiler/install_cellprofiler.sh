#!/bin/bash

#purge pip
ml Anaconda3
pip cache purge


# URL of the YAML file on GitHub
yaml_url="https://raw.githubusercontent.com/FrancisCrickInstitute/CALM/master/CellProfiler/cp_426.yml"
#file_name="cp_426.yml"

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

# Check to see if the environtment already exists
# Specify the path to your YAML file
yaml_file="$download_folder/cp_426.yml"

# Check if the file exists
if [ ! -f "$yaml_file" ]; then
    echo "Error: YAML file not found."
    exit 1
fi

# Find the name of the environment
environment_name=$(grep "name:" "$yaml_file" | awk '{print $2}')

# Check if the environment name is found in the YAML file
if [ -z "$environment_name" ]; then
    echo "Error: Environment name not found in the YAML file."
    exit 1
fi

# Check if the Conda environment exists
if conda env list | grep -q "$environment_name"; then
    # Remove the Conda environment
    conda env remove --name "$environment_name" --yes
    echo "Conda environment '$environment_name' removed."
else
    echo "Conda environment '$environment_name' not found."
fi

# Remove all whitespace characters, tabs, and newlines
environment_name="${environment_name// /}"
environment_name="${environment_name//$'\t'/}"
environment_name="${environment_name//$'\n'/}"
environment_name="${environment_name%?}"

# Load GCC module
ml GCC

# Load Java module
ml Java
echo "Loaded modules"

# Install dependencies using mamba and the downloaded yml file

cd $download_folder
echo "$PWD"

mamba env create --file cp_426.yml

# Check if the Conda environment exists
if conda env list | grep -q "$environment_name"; then
    echo "Conda environment '$environment_name' exists."
else
    echo "Error: Conda environment '$environment_name' not found. The environment failed. Retry, or call for help"
    exit 1
fi

echo "Created Environment"

# Clean up: remove the downloaded YAML file
rm "$download_folder/cp_426.yml"

echo "Script completed"