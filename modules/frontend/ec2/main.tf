resource "aws_instance" "frontend_instance" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  key_name                    = var.key_name
  vpc_security_group_ids      = [var.security_group_id]
  subnet_id                   = var.subnet_id
  associate_public_ip_address = true


  user_data = <<-EOF
                #!/bin/bash
              yum update -y
              dnf install nodejs -y
              yum install -y nginx
              systemctl start nginx
              systemctl enable nginx
              yum install git -y
              EOF

  tags = {
    Name = var.frontend_name
  }
}
