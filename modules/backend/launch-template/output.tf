output "backend_ami_id"{
    description = "backend AMI ID"
    value = aws_ami_from_instance.backend_ami.id
}

output "backend_launch_template_id" {
   description = "backend launch template id"
   value = aws_launch_template.backend.id
  
}

output "backend_launch_template_latest_version" {
  value = aws_launch_template.backend.latest_version
}