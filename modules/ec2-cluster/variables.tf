##################
# Input Variables
##################
variable "cluster_name" {
  description = "The name to use for cluster names"
  type = string
}

variable "cluster_min_size" {
  description = "Minimum size of cluster"
  type = number
}

variable "cluster_max_size" {
  description = "Maximum size of cluster"
  type = number
}

# variable "db_remote_state_bucket_name" {
#   description = "The bucket name for DB remote state"
#   type = string
# }

# variable "db_remote_state_key" {
#   description = "The path of DB remote state key file"
#   type = string
# }

variable "cluster_state_s3_bucket" {
  description = "The S3 bucket name of the cluster state file"
  type = string
}

variable "cluster_state_s3_key" {
  description = "The S3 bucket key file path of the cluster state file"
  type = string
}

###################
# Locals
###################
locals {
  http_port = 80
  http_protocol = "HTTP"
}