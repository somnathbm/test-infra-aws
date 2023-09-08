# create application database
resource "aws_db_instance" "mysql" {
  db_name = "tftest-db"
  instance_class = "db.t2.micro"
  allocated_storage = 10
  engine = "mysql"
  skip_final_snapshot = true
  username = var.db_username
  password = var.db_passwd
}