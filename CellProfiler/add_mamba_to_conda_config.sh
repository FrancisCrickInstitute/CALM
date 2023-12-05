#!/bin/bash

ml jq

# Get the list of Mamba environments
mamba_env_list=$(mamba info --envs --json | jq -r '.envs[]')

# Extract the last environment path and trim everything after "envs/"
trimmed_last_env_path=$(echo "$mamba_env_list" | tail -n 1 | sed 's|/envs/.*|/envs/|')

# Print the directory where Mamba environments are saved with trimming
echo "Mamba Environment Directory: $trimmed_last_env_path"

conda config --append envs_dirs $trimmed_last_env_path