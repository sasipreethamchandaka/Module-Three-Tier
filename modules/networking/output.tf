output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "frontend_private_subnet_ids" {
  value = [
    aws_subnet.frontend_pvt_1.id,
    aws_subnet.frontend_pvt_2.id
  ]

}

output "backend_private_subnet_ids" {
  value = [
    aws_subnet.backend_pvt_1.id,
    aws_subnet.backend_pvt_2.id
  ]

}

output "lb_public_subnet_ids" {
  value = [
    aws_subnet.lb_public-1.id,
    aws_subnet.lb_public-2.id
  ]

}

output "rds_private_subnet_ids" {
  value = [
    aws_subnet.rds_private-1.id,
    aws_subnet.rds_private-2.id
  ]

}

output "security_group_id" {
  value = aws_security_group.bastion_host.id
}

output "rds_sg_id" {
  value = aws_security_group.rds_sg.id
}