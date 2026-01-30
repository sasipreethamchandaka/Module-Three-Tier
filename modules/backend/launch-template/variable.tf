variable "back_ami_name" {
  description = "Name of the frontend AMI"
  type        = string
}

variable "source_instance_id" {
  type = string
}

variable "backend_launch_template_name" {
  type = string
}

variable "backend_launch_template_description" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "key_name" {
  type = string
}

variable "security_group_id" {
  type = string
}

variable "backend_instance_name" {
  type = string
}