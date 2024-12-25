# Application Load Balancer (Internet-facing)
resource "aws_lb" "internet_alb" {
  name               = "${var.stack_name}-InternetALB"
  internal           = false
  load_balancer_type = "application"
  security_groups   = [var.alb_security_group_id]
  subnets            = var.public_subnets

  enable_deletion_protection = false
  idle_timeout {
    timeout_seconds = 60
  }

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

# ALB Target Group (Private EC2)
resource "aws_lb_target_group" "alb_public_target_group" {
  name     = "${var.stack_name}-ALB-PublicTargetGroup"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    protocol            = "HTTP"
    path                = "/ec2meta-webpage/index.php"
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

  # Private EC2 인스턴스를 대상으로 트래픽을 전달
  targets {
    id   = var.private_instance_1_id
    port = 80
  }

  targets {
    id   = var.private_instance_2_id
    port = 80
  }
}