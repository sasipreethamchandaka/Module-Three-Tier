resource "aws_instance" "backend_instance" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  key_name                    = var.key_name
  vpc_security_group_ids      = [var.security_group_id]
  subnet_id                   = var.subnet_id
  associate_public_ip_address = true

  user_data = <<-EOF
              #!/bin/bash
              sudo yum update -y
              sudo npm install -g pm2
              yum install git -y
              dnf install mariadb105-server -y
              EOF

  tags = {
    Name = var.backend_name
  }
}