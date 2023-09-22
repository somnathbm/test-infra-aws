include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "github.com/somnathbm/test-aws-module//modules/ec2-server?ref=v1.0.0"
}