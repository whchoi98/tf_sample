#!/bin/bash

# Base directory
BASE_DIR="./iam"

# Subdirectories for IAM resources
SUBDIRS=("roles" "policies" "users" "groups" "shared")

# Create base directory
mkdir -p $BASE_DIR

# Loop through subdirectories and create required files
for subdir in "${SUBDIRS[@]}"; do
    mkdir -p "$BASE_DIR/$subdir"
    # Create main.tf, variables.tf, outputs.tf in each subdirectory
    touch "$BASE_DIR/$subdir/main.tf"
    touch "$BASE_DIR/$subdir/variables.tf"
    touch "$BASE_DIR/$subdir/outputs.tf"

    # Populate main.tf with a placeholder
    cat > "$BASE_DIR/$subdir/main.tf" <<EOL
# $subdir - Main Configuration
# Define your $subdir resource here
EOL

    # Populate variables.tf with a placeholder
    cat > "$BASE_DIR/$subdir/variables.tf" <<EOL
# $subdir - Variables
# Define your $subdir variables here
EOL

    # Populate outputs.tf with a placeholder
    cat > "$BASE_DIR/$subdir/outputs.tf" <<EOL
# $subdir - Outputs
# Define your $subdir outputs here
EOL
done

echo "IAM module directories and files created successfully!"