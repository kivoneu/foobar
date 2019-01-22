#!/usr/bin/env bash

echo 'Set terraform variables'
TF_VAR_state_file_bucket=terraform-remote-state
TF_VAR_lock_table_name=terraform-state-lock-dynamo
TF_VAR_region=us-east-1

echo 'Terraform init'
echo "bucket=${TF_VAR_state_file_bucket} -backend-config=region=${TF_VAR_region}"
terraform init
#terraform init -backend-config="bucket=${TF_VAR_state_file_bucket}" -backend-config="region=${TF_VAR_region}"

echo 'Terraform apply'
terraform apply -var-file="./terraform.tfvars"
