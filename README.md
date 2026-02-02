 #              Terraform AWS Application Deployment

This project provisions and deploys a **three-tier application
(Frontend + Backend + Database)** on AWS using **Terraform modules**.

---

##  Components Provisioned

- VPC & Networking
- Bastion Host
- Frontend EC2 Instance
- Backend EC2 Instance
- Frontend Application Load Balancer
- Backend Application Load Balancer
- Launch Templates (Frontend & Backend)
- Amazon RDS (MySQL)

> ⚠️ Auto Scaling Groups are currently commented out in the Terraform code.

---

## Architecture Overview

### Frontend
- EC2 instance behind Frontend ALB
- Launch Template prepared for scaling
- Communicates with Backend via Backend ALB

### Backend
- EC2 instance behind Backend ALB
- Launch Template prepared for scaling
- Connects to RDS using private subnets

### Database
- Amazon RDS (MySQL)
- Deployed in private subnets

---

## Prerequisites

- Terraform >= 1.x
- AWS CLI configured
- Existing AWS EC2 Key Pair (`sasich`)
- Valid AMI ID for the selected region (`us-east-1`)

---

## Deployment Flow

> ⚠️ `-target` is used only for **staged deployment and learning purposes**.  
> In production, a single `terraform apply` is recommended.

---

### Step 1: Initialize Terraform

```bash
terraform init
```

### Step 2: Apply Networking

``` bash
terraform plan  -target=module.networking
terraform apply -target=module.networking
```

### Step 3: Deploy Bastion Host

``` bash
terraform plan -target=module.bastion
terraform apply -target=module.bastion
```

### Step 4: Deploy EC2 Instances

``` bash
terraform plan  -target=module.frontend_ec2
terraform apply -target=module.frontend_ec2

terraform plan -target=module.backend_ec2
terraform apply -target=module.backend_ec2
```

### Step 5: Deploy Load Balancers

``` bash
terraform plan  -target=module.frontend_lb
terraform apply -target=module.frontend_lb

terraform plan  -target=module.backend_lb
terraform apply -target=module.backend_lb
```

### Step 6: Deploy Launch Templates
- ⚠️ Launch Templates depend on EC2 instances

``` bash
terraform plan  -target=module.frontend_launch_template
terraform apply -target=module.frontend_launch_template

terraform plan  -target=module.backend_launch_template
terraform apply -target=module.backend_launch_template
```

### Step 7: Deploy RDS Database

``` bash
terraform plan  -target=module.rds_database
terraform apply -target=module.rds_database
```

### Step 8: Apply Remaining Modules

``` bash
# terraform plan -target=module.backend_asg
# terraform apply -target=module.backend_asg
# terraform plan -target=module.frontend_asg
# terraform apply -target=module.frontend_asg
```

### Step 9: Final Apply (Recommended)

``` bash
terraform apply
```
- This ensures all remaining dependencies are properly resolved.
------------------------------------------------------------------------

## Application Deployment

### Backend

-   Connect via Bastion or create in public subnet
-   Deploy backend application
-   Configure RDS details in `.env` file

### Frontend

-   Connect via Bastion or create in public subnet
-   Update Backend ALB URL in frontend config
-   Deploy frontend application

------------------------------------------------------------------------

## Author
Mahima Patel 
DevOps & Cloud Engineering   

GitHub: https://github.com/sasipreethamchandaka
