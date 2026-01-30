output "frontend_instance_ids" {
  value = aws_instance.frontend_instance.id

}

output "frontend_instance_public_ips" {
  value = aws_instance.frontend_instance.public_ip # list of public IPs of all frontend instances
}

output "frontend_instance_private_ips" {
  value = aws_instance.frontend_instance.private_ip # list of private IPs of all frontend instances
}