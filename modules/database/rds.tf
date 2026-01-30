# rds subnet group creation

resource "aws_db_subnet_group" "rds_db_group" {

  name       = var.subnet_group_name
  subnet_ids = var.subnet_ids

  tags = {
    Name = var.subnet_group_name
  }
}

# rds instannce cration

resource "aws_db_instance" "three-tier-rds" {
  identifier        = var.identifier
  allocated_storage = var.allocated_storage
  engine            = var.engine
  engine_version    = var.engine_version
  instance_class    = var.instance_class
  username          = var.db_username
  password          = var.db_password

  skip_final_snapshot = true

  vpc_security_group_ids = [var.rds_sg_id]
  publicly_accessible    = false

  backup_retention_period = 7
  db_subnet_group_name    = aws_db_subnet_group.rds_db_group.name

  tags = {
    Name = var.rds_name
  }
}