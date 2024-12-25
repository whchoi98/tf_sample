# Network Load Balancer (Internet-facing)
resource "aws_lb" "internet_nlb" {
  name               = "${var.stack_name}-InternetNLB"
  internal           = false
  load_balancer_type = "network"
  security_groups   = [var.nlb_security_group_id]
  subnets            = var.public_subnets

  enable_deletion_protection = false

  tags = merge(var.common_tags, {
    Name = "${var.stack_name}-InternetNLB"
  })
}

# NLB Listener (Public)
resource "aws_lb_listener" "nlb_public_listener" {
  load_balancer_arn = aws_lb.internet_nlb.arn
  port              = 80
  protocol          = "TCP"

  default_action {
    target_group_arn = aws_lb_target_group.nlb_public_target_group.arn
    type             = "forward"
  }
}

# NLB Target Group (Private EC2)
resource "aws_lb_target_group" "nlb_public_target_group" {
  name     = "${var.stack_name}-NLB-PublicTargetGroup"
  port     = 80
  protocol = "TCP"
  vpc_id   = var.vpc_id

  tags = merge(var.common_tags, {
    Name = "${var.stack_name}-NLB-PublicTargetGroup"
  })

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