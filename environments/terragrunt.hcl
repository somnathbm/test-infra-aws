locals {
  # Parse the file path we're in.
  parsed = regex(".*/environments/(?P<env>.*?)/.*", get_terragrunt_dir())
  env = local.parsed.env
  account = yamldecode(file("${local.env}/account.yaml"))
}

# configure s3 as backend, but with environment-scoped bucket names
remote_state {
  backend = "s3"
  config = {
    bucket = local.account.s3_state.bucket
    region = local.account.region
    key = "${path_relative_to_include()}/terraform.tfstate"
    encrypt = true
    role_arn = "arn:aws:iam::${local.account.id}:role/${local.account.role_name}"
    dynamodb_table = local.account.s3_state.dynamo_table
  }
  generate = {
    path = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
}

generate "provider" {
  path = "provider.tf"
  if_exists = "overwrite"
  contents = <<EOF
  provider "aws" {
    region = "${local.account.region}"
    assume_role {
      role_arn = "arn:aws:iam::${local.account.id}:role/${local.account.role_name}"
    }
  }
  EOF
}