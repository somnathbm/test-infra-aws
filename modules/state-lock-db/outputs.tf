###############
# Outputs
###############
output "table_name" {
  value = aws_dynamodb_table.state_lock.name
}