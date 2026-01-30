output "bastion_host_id" {
  value = aws_instance.bation_host.id
}

output "bastion_host_public_ip" {
  value = aws_instance.bation_host.public_ip
}

output "bastion_host_private_ip" {
  value = aws_instance.bation_host.private_ip
}