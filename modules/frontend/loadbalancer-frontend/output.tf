output "frontend_lb_arn" {
  value = aws_lb.frontend.arn
}

output "frontend_lb_dns_name" {
  value = aws_lb.frontend.dns_name
}

output "frontend_tg_arn" {
  value = aws_lb_target_group.frontend.arn
}