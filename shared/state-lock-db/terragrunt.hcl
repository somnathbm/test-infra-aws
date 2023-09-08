include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "../../modules/state-lock-db"
}

inputs = {
  table_name = "awsinfra-state-lock"
}