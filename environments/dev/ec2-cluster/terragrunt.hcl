# Automatically find root terragrunt.hcl
include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "../../modules/ec2-cluster"
}

inputs = {
  cluster_name = "awsinfra-dev"
  cluster_min_size = 1
  cluster_max_size = 3
}