module "networking" {
  source         = "../../modules/networking"
  vpc_cidr_block = "10.0.0.0/16"

  vpc_name = "three-tier-vpc"

  frontend_pvt_subnet_1_cidr_block = "10.0.1.0/24"
  frontend_pvt_subnet_2_cidr_block = "10.0.2.0/24"
  backend_pvt_subnet_1_cidr_block  = "10.0.3.0/24"
  backend_pvt_subnet_2_cidr_block  = "10.0.4.0/24"
  lb_public_subnet_1_cidr_block    = "10.0.5.0/24"
  lb_public_subnet_2_cidr_block    = "10.0.6.0/24"
  rds_private_subnet_1_cidr_block  = "10.0.7.0/24"
  rds_private_subnet_2_cidr_block  = "10.0.8.0/24"

  subnet_1a_az = "us-east-1a"
  subnet_1b_az = "us-east-1b"

  frontend_pvt_1_name = "-frontend-private-subnet-1"
  frontend_pvt_2_name = "dev-frontend-private-subnet-2"
  backend_pvt_1_name  = "dev-backend-private-subnet-1"
  backend_pvt_2_name  = "dev-backend-private-subnet-2"
  lb_public_1_name    = "dev-lb-public-subnet-1"
  lb_public_2_name    = "dev-lb-public-subnet-2"
  rds_private_1_name  = "dev-rds-private-subnet-1"
  rds_private_2_name  = "dev-rds-private-subnet-2"

  allowed_ssh_cidr = ["0.0.0.0/0"]
}

# bation server module

module "bastion" {
  source            = "../../modules/bastion"
  ami_id            = "ami-068c0051b15cdb816"
  instance_type     = "t2.micro"
  bation_name       = "three-tier-bastion"
  subnet_id         = module.networking.lb_public_subnet_ids[0]
  security_group_id = module.networking.security_group_id
}


# frontend ec2 module
module "frontend_ec2" {
  source            = "../../modules/frontend/ec2"
  ami_id            = "ami-068c0051b15cdb816"
  instance_type     = "t2.micro"
  frontend_name     = "three-tier-frontend"
  subnet_id         = module.networking.lb_public_subnet_ids[0]
  security_group_id = module.networking.security_group_id
  key_name          = "sasich" # Replace with your key pair name 
}


# frontend load balancer module
module "frontend_lb" {
  source               = "../../modules/frontend/loadbalancer-frontend"
  front_lb_name        = "front-LB"
  front_tg_name        = "front-TG"
  vpc_id               = module.networking.vpc_id
  front_lb_sg_id       = module.networking.security_group_id
  lb_public_subnet_ids = module.networking.lb_public_subnet_ids

}

# front launch template
module "frontend_launch_template" {
  source                               = "../../modules/frontend/launch-template"
  front_ami_name                       = "frontend_ami"
  source_instance_id                   = module.frontend_ec2.frontend_instance_ids
  frontend_launch_template_name        = "frontend_launch_template"
  frontend_launch_template_description = "Frontend-Launch-Template"
  instance_type                        = "t3.micro"
  key_name                             = "sasich"
  security_group_id                    = module.networking.security_group_id
  frontend_instance_name               = "three-tier-front-temp"
}


# frontend ASG

# module "frontend_asg" {
#   source = "../../modules/frontend/asg"

#   frontend_asg_name = "three-frontend_asg"

#   min_size                  = 1
#   max_size                  = 1
#   frontend_desired_capacity = 1

#   private_subnet_ids = module.networking.frontend_private_subnet_ids

#   frontend_target_group_arn      = module.frontend_lb.frontend_tg_arn
#   frontend_launch_template_id    = module.frontend_launch_template.frontend_launch_template_id
#   frontend_scale_out_policy_name = "three-tier-frontend-scale-out"
#   scale_out_target_value         = 80

# }

#backend--------------------

# backend ec2 module
module "backend_ec2" {
  source            = "../../modules/backend/ec2"
  ami_id            = "ami-068c0051b15cdb816"
  instance_type     = "t2.micro"
  backend_name      = "three-tier-backend"
  subnet_id         = module.networking.lb_public_subnet_ids[0]
  security_group_id = module.networking.security_group_id
  key_name          = "sasich" # Replace with your key pair name 
}



# backend load balancer module
module "backend_lb" {
  source               = "../../modules/backend/loadbalancer-backend"
  back_lb_name         = "back-LB"
  back_tg_name         = "back-TG"
  vpc_id               = module.networking.vpc_id
  back_lb_sg_id        = module.networking.security_group_id
  lb_public_subnet_ids = module.networking.lb_public_subnet_ids

}



# backend launch template
module "backend_launch_template" {
  source                              = "../../modules/backend/launch-template"
  back_ami_name                       = "backend_ami"
  source_instance_id                  = module.backend_ec2.backend_instance_ids[0]
  backend_launch_template_name        = "backend_launch_template"
  backend_launch_template_description = "backend-Launch-Template"
  instance_type                       = "t3.micro"
  key_name                            = "sasich"
  security_group_id                   = module.networking.security_group_id
  backend_instance_name               = "three-tier-back-temp"
}


# backend asg craetion
# module "backend_asg" {
#   source = "../../modules/backend/asg"

#   backend_asg_name = "three-backend_asg"

#   min_size                 = 1
#   max_size                 = 1
#   backend_desired_capacity = 1

#   private_subnet_ids = module.networking.backend_private_subnet_ids

#   backend_target_group_arn      = module.backend_lb.backend_tg_arn
#   backend_launch_template_id    = module.backend_launch_template.backend_launch_template_id
#   backend_scale_out_policy_name = "three-tier-backend-scale-out"
#   scale_out_target_value        = 80

# }


# rds database creation

module "rds_database" {
  source            = "../../modules/database"
  subnet_group_name = "three-tire-subnet-group"
  subnet_ids        = module.networking.rds_private_subnet_ids
  identifier        = "three-tier-db"
  allocated_storage = 20
  engine_version    = "8.0"
  engine            = "mysql"
  instance_class    = "db.t3.micro"
  db_username       = "admin"
  db_password       = "admin1234"
  rds_sg_id         = module.networking.rds_sg_id
  rds_name          = "three-tire-rds-db"
  rds_sg_tag_name   = "three-tier-rds-sg"

}   