
# VPC
variable "vpc_cidr_block" {
  description = "The CIDR block for the VPC"
  type        = string
}

variable "vpc_name" {
  description = "The name of the VPC"
  type        = string
}


# Frontend Private Subnets
variable "frontend_pvt_subnet_1_cidr_block" {
  description = "CIDR block for frontend private subnet 1"
  type        = string
}

variable "frontend_pvt_1_name" {
  description = "Name of frontend private subnet 1"
  type        = string
}

variable "frontend_pvt_subnet_2_cidr_block" {
  description = "CIDR block for frontend private subnet 2"
  type        = string
}

variable "frontend_pvt_2_name" {
  description = "Name of frontend private subnet 2"
  type        = string
}


# Backend Private Subnets
variable "backend_pvt_subnet_1_cidr_block" {
  description = "CIDR block for backend private subnet 1"
  type        = string
}

variable "backend_pvt_1_name" {
  description = "Name of backend private subnet 1"
  type        = string
}

variable "backend_pvt_subnet_2_cidr_block" {
  description = "CIDR block for backend private subnet 2"
  type        = string
}

variable "backend_pvt_2_name" {
  description = "Name of backend private subnet 2"
  type        = string
}


# Availability Zones
variable "subnet_1a_az" {
  description = "Availability zone for subnet 1a"
  type        = string
}

variable "subnet_1b_az" {
  description = "Availability zone for subnet 1b"
  type        = string
}


# Load Balancer Public Subnets
variable "lb_public_subnet_1_cidr_block" {
  description = "CIDR block for LB public subnet 1"
  type        = string
}

variable "lb_public_1_name" {
  description = "Name of LB public subnet 1"
  type        = string
}

variable "lb_public_subnet_2_cidr_block" {
  description = "CIDR block for LB public subnet 2"
  type        = string
}

variable "lb_public_2_name" {
  description = "Name of LB public subnet 2"
  type        = string
}


# RDS Private Subnets
variable "rds_private_subnet_1_cidr_block" {
  description = "CIDR block for RDS private subnet 1"
  type        = string
}

variable "rds_private_1_name" {
  description = "Name of RDS private subnet 1"
  type        = string
}

variable "rds_private_subnet_2_cidr_block" {
  description = "CIDR block for RDS private subnet 2"
  type        = string
}

variable "rds_private_2_name" {
  description = "Name of RDS private subnet 2"
  type        = string
}


# Security
variable "allowed_ssh_cidr" {
  description = "Allowed CIDR blocks for SSH"
  type        = list(string)
}