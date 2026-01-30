output "backend_instance_ids" {
  value = aws_instance.backend_instance.*.id

}

output "backend_instance_public_ips" {
  value = aws_instance.backend_instance.*.public_ip # list of public IPs of all frontend instances
}

output "backend_instance_private_ips" {
  value = aws_instance.backend_instance.*.private_ip # list of private IPs of all frontend instances
}