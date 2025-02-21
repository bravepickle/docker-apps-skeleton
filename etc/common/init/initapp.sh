#!/bin/bash
# Script to run init shell scripts
# They will be run only once on first execution. If new added or symlink to target script will be deleted then
# it will be executed once again
# Warning! You should create & mount different "initapp.d" folders for different contexts, applications.
# Do not push everything to one place if it makes mess or may create conflicts

set -e

# Source and target directories
SOURCE_DIR="/docker-scripts/initapp.d"
TARGET_DIR="/docker-scripts/initapp.d-executed"

# Create the target directory if it doesn't exist
mkdir -p "$TARGET_DIR"

# Traverse all *.sh files in the source directory
for script in "$SOURCE_DIR"/*.sh; do
    # Skip if not a file
    [ -f "$script" ] || continue

    # Get the base name of the script (e.g., script.sh)
    script_name=$(basename "$script")

    # Symlink path in the target directory
    symlink_path="$TARGET_DIR/$script_name"

    # Check if the symlink already exists
    if [ -L "$symlink_path" ]; then
        echo "Skipping already executed script: $script_name"
        continue
    fi

    # Execute the script
    echo "Executing: $script"
    bash "$script"

    # Create a symlink to mark the script as executed
    ln -s "$script" "$symlink_path"
    echo "Symlink created for: $script_name"
done
