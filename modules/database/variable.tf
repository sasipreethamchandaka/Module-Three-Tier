variable "subnet_group_name" {
  type = string
}

variable "subnet_ids" {
  type = list(string)
}

variable "rds_sg_tag_name" {
  description = "Tag name for the RDS security group"
  type        = string
}

variable "identifier" {
  type = string
}

variable "allocated_storage" {
  type = number
}

variable "engine_version" {
  type = string
}

variable "engine" {
  type = string
}

variable "instance_class" {
  type = string
}

variable "db_username" {
  type = string
}

variable "db_password" {
  type = string
}

variable "rds_sg_id" {
  type = string
}

variable "rds_name" {
  type = string
}