#!/bin/bash

#get file from https://github.com/qupath/qupath/releases/download/v0.5.0/QuPath-v0.5.0-Linux.tar.xz

current_directory=$(pwd)
QuPath_URL="https://github.com/qupath/qupath/releases/download/v0.5.0/QuPath-v0.5.0-Linux.tar.xz"
filename=$(basename "$QuPath_URL")

wget -O "$current_directory/$filename" "$QuPath_URL"

#unzip the file
tar -xf QuPath*

#change directory to the QuPath/bin
cd $(ls -d QuPath*)
cd bin

#modify the permissions on QuPath launcher
chmod u+x QuPath

current_directory=$(pwd)
rm 
# Create a file in the home directory to save the current directory
output_file="$HOME/Run_QuPath.sh"

echo "cd $current_directory/" > "$output_file"
echo "./QuPath" >> "$output_file"

echo "File created at: $output_file"

cd $HOME
chmod u+x $output_file