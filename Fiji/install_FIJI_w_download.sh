#!/bin/bash

#get file from https://downloads.micron.ox.ac.uk/fiji_update/mirrors/fiji-latest/fiji-linux64.zip

current_directory=$(pwd)
FIJI_URL="https://downloads.micron.ox.ac.uk/fiji_update/mirrors/fiji-latest/fiji-linux64.zip"
filename=$(basename "$FIJI_URL")

wget -O "$current_directory/$filename" "$FIJI_URL"

#unzip the file
unzip $filename

#change directory to the Fiji
cd Fiji.app

#modify the permissions on Fiji launcher
chmod u+x ImageJ-linux64

current_directory=$(pwd)
rm 
# Create a file in the home directory to save the current directory
output_file="$HOME/Run_Fiji.sh"

echo "cd $current_directory/" > "$output_file"
echo "./ImageJ-linux64" >> "$output_file"

echo "File created at: $output_file"

cd $HOME
chmod u+x $output_file

#remove the downloaded file
chmod u+x fiji-linux64.zip
rm fiji-linux64.zip
