#!/bin/bash

# 사용자로부터 디렉터리 이름 입력받기
read -p "Enter the root directory name for your Terraform project: " ROOT_DIR

# 입력값이 비어있을 경우 기본값 설정
if [[ -z "$ROOT_DIR" ]]; then
  echo "No directory name provided. Using default name: terraform-project"
  ROOT_DIR="terraform-project"
fi

# Directory structure
declare -a DIRS=(
  "$ROOT_DIR/envs/dev"
  "$ROOT_DIR/envs/staging"
  "$ROOT_DIR/envs/prod"
  "$ROOT_DIR/modules/vpc"
  "$ROOT_DIR/modules/ec2"
  "$ROOT_DIR/modules/rds"
  "$ROOT_DIR/modules/elasticache"
  "$ROOT_DIR/modules/security-group"
  "$ROOT_DIR/modules/routing-table"
  "$ROOT_DIR/modules/prefix-list"
  "$ROOT_DIR/modules/alb"
  "$ROOT_DIR/modules/nlb"
  "$ROOT_DIR/shared"
  "$ROOT_DIR/terraform.tfstate.d/dev"
  "$ROOT_DIR/terraform.tfstate.d/staging"
  "$ROOT_DIR/terraform.tfstate.d/prod"
)

# Files to create
declare -a FILES=(
  "$ROOT_DIR/envs/dev/main.tf"
  "$ROOT_DIR/envs/dev/variables.tf"
  "$ROOT_DIR/envs/dev/outputs.tf"
  "$ROOT_DIR/envs/dev/terraform.tfvars"
  "$ROOT_DIR/envs/staging/main.tf"
  "$ROOT_DIR/envs/staging/variables.tf"
  "$ROOT_DIR/envs/staging/outputs.tf"
  "$ROOT_DIR/envs/staging/terraform.tfvars"
  "$ROOT_DIR/envs/prod/main.tf"
  "$ROOT_DIR/envs/prod/variables.tf"
  "$ROOT_DIR/envs/prod/outputs.tf"
  "$ROOT_DIR/envs/prod/terraform.tfvars"
  "$ROOT_DIR/modules/vpc/main.tf"
  "$ROOT_DIR/modules/vpc/variables.tf"
  "$ROOT_DIR/modules/vpc/outputs.tf"
  "$ROOT_DIR/modules/ec2/main.tf"
  "$ROOT_DIR/modules/ec2/variables.tf"
  "$ROOT_DIR/modules/ec2/outputs.tf"
  "$ROOT_DIR/modules/rds/main.tf"
  "$ROOT_DIR/modules/rds/variables.tf"
  "$ROOT_DIR/modules/rds/outputs.tf"
  "$ROOT_DIR/modules/elasticache/main.tf"
  "$ROOT_DIR/modules/elasticache/variables.tf"
  "$ROOT_DIR/modules/elasticache/outputs.tf"
  "$ROOT_DIR/modules/security-group/main.tf"
  "$ROOT_DIR/modules/security-group/variables.tf"
  "$ROOT_DIR/modules/security-group/outputs.tf"
  "$ROOT_DIR/modules/routing-table/main.tf"
  "$ROOT_DIR/modules/routing-table/variables.tf"
  "$ROOT_DIR/modules/routing-table/outputs.tf"
  "$ROOT_DIR/modules/prefix-list/main.tf"
  "$ROOT_DIR/modules/prefix-list/variables.tf"
  "$ROOT_DIR/modules/prefix-list/outputs.tf"
  "$ROOT_DIR/modules/alb/main.tf"
  "$ROOT_DIR/modules/alb/variables.tf"
  "$ROOT_DIR/modules/alb/outputs.tf"
  "$ROOT_DIR/modules/nlb/main.tf"
  "$ROOT_DIR/modules/nlb/variables.tf"
  "$ROOT_DIR/modules/nlb/outputs.tf"
  "$ROOT_DIR/shared/providers.tf"
  "$ROOT_DIR/shared/variables.tf"
  "$ROOT_DIR/shared/terraform.tfvars"
  "$ROOT_DIR/shared/outputs.tf"
  "$ROOT_DIR/README.md"
)

# Create directories
echo "Creating directories for $ROOT_DIR..."
for dir in "${DIRS[@]}"; do
  mkdir -p "$dir"
  echo "Created directory: $dir"
done

# Create files
echo "Creating files for $ROOT_DIR..."
for file in "${FILES[@]}"; do
  touch "$file"
  echo "Created file: $file"
done

echo "Terraform directory structure created successfully for $ROOT_DIR!"