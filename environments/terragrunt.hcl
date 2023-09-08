locals {
  # Parse the file path we're in.
  parsed = regex(".*/environments/(?P<env>.*?)/.*", get_terragrunt_dir())
  env = local.parsed.env
}

dependency "state_lock_db" {
  config_path = "../shared/state-lock-db"
}

# configure s3 as backend, but with environment-scoped bucket names
remote_state {
  backend = "s3"
  config = {
    bucket = "awsinfra-state-s3"
    region = "us-east-1"
    key = "${path_relative_to_include()}/terraform.tfstate"
    encrypt = true
    role_arn = "arn:aws:iam::691685274845:role/AwsageEngnrDevOrgAccessRole"
    dynamodb_table = dependency.state_lock_db.outputs.table_name
  }
  generate = {
    path = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
}