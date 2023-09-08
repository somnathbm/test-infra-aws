# fetch default VPC
data "aws_vpc" "default" {
  default = true
}

# fetch security groups
data "aws_security_groups" "apache" {
  tags = {
    Name = "apache_sg"
  }
}

# fetch subnets
data "aws_subnets" "default" {
  tags = {
    Name = "us_east_1"
  }
}

data "terraform_remote_state" "db" {
  backend = "s3"

  config = {
    bucket = var.db_remote_state_bucket_name
    key = var.db_remote_state_key
    region = "us-east-1"
  }
}