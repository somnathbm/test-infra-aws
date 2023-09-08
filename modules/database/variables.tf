variable "db_username" {
  type = string
  description = "master username"
  sensitive = true
}

variable "db_passwd" {
  type = string
  description = "master password"
  sensitive = true
}