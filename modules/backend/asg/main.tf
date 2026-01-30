# # frontend ASG

# resource "aws_autoscaling_group" "backend_asg"{
#   name             = var.backend_asg_name
#   min_size         = var.min_size
#   max_size         = var.max_size
#   desired_capacity = var.backend_desired_capacity
#   vpc_zone_identifier = var.private_subnet_ids
#   target_group_arns = [var.backend_target_group_arn]
#   health_check_type = "EC2"

#   launch_template {
#     id = var.backend_launch_template_id
#     version = "$Latest"
#   }
 

#   instance_refresh {
#     strategy = "Rolling"
#     preferences {
#       min_healthy_percentage = 50
#     }
#     triggers = ["desired_capacity"]
#   }

#   tag {
#     key                 = "Name"
#     value               = var.backend_asg_name
#     propagate_at_launch = true
#   }

# }

# # frontend sacle-out Policy

#   resource "aws_autoscaling_policy" "back_scale_out" {
#     name = var.backend_scale_out_policy_name
#     autoscaling_group_name = aws_autoscaling_group.backend_asg.name
#     policy_type = "TargetTrackingScaling"

#     target_tracking_configuration {
#       predefined_metric_specification {
#         predefined_metric_type = "ASGAverageCPUUtilization"
#       }
#       target_value = var.scale_out_target_value
#       disable_scale_in = false
#     }
#   }
  