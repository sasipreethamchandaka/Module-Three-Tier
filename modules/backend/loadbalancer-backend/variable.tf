variable "back_lb_name" {
  description = "the name of the frontend load balancer"
  type        = string
}

variable "back_tg_name" {
  description = "the name of the frontend target group"
  type        = string
}

variable "vpc_id" {
    description = "the id of the vpc where the lb will be created"
    type        = string
    }

variable "back_lb_sg_id" {
    description = "the security group id for the frontend load balancer"
    type        = string
    }

variable "lb_public_subnet_ids" {
    description = "the public subnet ids for the load balancer"
    type        = list(string)
    }
    
    