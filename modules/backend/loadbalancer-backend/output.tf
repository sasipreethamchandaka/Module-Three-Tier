output "backend_lb_arn" {
  value = aws_lb.backend.arn
}

output "backend_lb_dns_name" {
  value = aws_lb.backend.dns_name
}

output "backend_tg_arn" {
  value = aws_lb_target_group.backend.arn
}