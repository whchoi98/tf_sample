# 인터넷을 통한 Application Load Balancer / Internet-facing Application Load Balancer
resource "aws_lb" "internet_alb" {
  name               = "${var.stack_name}-InternetALB"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.alb_security_group_id]
  subnets            = var.public_subnets

  idle_timeout       = 60
  enable_deletion_protection = false

  tags = merge(var.common_tags, {
    Name = "${var.stack_name}-InternetALB"
  })
}

# ALB Listener (Public)
resource "aws_lb_listener" "alb_public_listener" {
  load_balancer_arn = aws_lb.internet_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_lb_target_group.alb_public_target_group.arn
    type             = "forward"
  }
}

# ALB Target Group
resource "aws_lb_target_group" "alb_public_target_group" {
  name     = "${var.stack_name}-ALB-PublicTargetGroup"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    protocol            = "HTTP"
    path                = "/ec2meta-webpage/index.php" # 애플리케이션에 맞게 변경 필요
    healthy_threshold   = 5
    unhealthy_threshold = 2
    timeout_seconds     = 5
    interval_seconds    = 30
    success_codes       = "200"
  }

  tags = merge(var.common_tags, {
    Name = "${var.stack_name}-ALB-PublicTargetGroup"
  })

  target_group_attributes {
    key   = "deregistration_delay.timeout_seconds"
    value = "300"
  }

  target_group_attributes {
    key   = "stickiness.enabled"
    value = "false"
  }

  target_group_attributes {
    key   = "stickiness.type"
    value = "lb_cookie"
  }

  target_group_attributes {
    key   = "stickiness.lb_cookie.duration_seconds"
    value = "86400"
  }
}

# ALB Target Group Attachments
resource "aws_lb_target_group_attachment" "alb_target_attachments" {
  count            = length(var.private_instance_ids)
  target_group_arn = aws_lb_target_group.alb_public_target_group.arn
  target_id        = var.private_instance_ids[count.index]
  port             = 80
}