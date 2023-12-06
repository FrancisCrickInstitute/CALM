#!/bin/bash
#TODO make the list of plugins a list we can iterate over
#TODO check if all files are downloaded properly
#TODO get the name of the plugin from the URL so that we can iterate over the list and download without specifiying the destination file name
# Check if the number of arguments is correct
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <folder_path>"
    exit 1
fi

# Get the folder path from the command line argument
folder_path=$1

# Check if the folder exists, and create it if it doesn't
if [ ! -d "$folder_path" ]; then
    mkdir -p "$folder_path"
    echo "Created folder: $folder_path"
else
    echo "Folder already exists: $folder_path"
fi

# URL of the plugins on CellProfiler website
stardist_plugin="https://raw.githubusercontent.com/CellProfiler/CellProfiler-plugins/master/active_plugins/runstardist.py"
cellpose_plugin="https://raw.githubusercontent.com/CellProfiler/CellProfiler-plugins/master/active_plugins/runcellpose.py"
omnipose_plugin="https://raw.githubusercontent.com/CellProfiler/CellProfiler-plugins/master/active_plugins/runomnipose.py"


# Download the files
wget -O "$folder_path/runstardist.py" "$stardist_plugin"
wget -O "$folder_path/runcellpose.py" "$cellpose_plugin"
wget -O "$folder_path/runomnipose.py" "$omnipose_plugin"

# Check if the download was successful
if [ $? -eq 0 ]; then
    echo "Files downloaded successfully."
else
    echo "Failed to download the files. Exiting."
    exit 1
fi