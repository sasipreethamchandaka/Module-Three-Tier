# frontend load balancer target group

resource "aws_lb_target_group" "frontend" {
    name = var.front_tg_name
    port = 80
    protocol = "HTTP"
    vpc_id = var.vpc_id
    health_check {
        path                = "/"
        protocol            = "HTTP"
        matcher             = "200-399"
        interval            = 30
        timeout             = 5
        healthy_threshold   = 2
        unhealthy_threshold = 2
    }

}

# frontend load balancer

resource "aws_lb" "frontend" {
    name               = var.front_lb_name
    internal           = false
    load_balancer_type = "application"
    security_groups    = [var.front_lb_sg_id]
    subnets            = var.lb_public_subnet_ids

    enable_deletion_protection = false
}

# frontend load balancer listener
resource "aws_lb_listener" "frontend_listner" {
    load_balancer_arn = aws_lb.frontend.arn
    port              = 80
    protocol          = "HTTP"

    default_action {
        type             = "forward"
        target_group_arn = aws_lb_target_group.frontend.arn
    }
}