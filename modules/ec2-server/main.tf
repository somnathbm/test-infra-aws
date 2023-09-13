resource "aws_instance" "server" {
  launch_template {
    name = "Apache"
  }

  security_groups = ["apache_sg-20230829085354162900000001"]
  tags = {
    Name = "my-server-002"
  }
}