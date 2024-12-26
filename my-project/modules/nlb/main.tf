# Network Load Balancer (NLB) / 네트워크 로드 밸런서 (NLB)
# 인터넷을 통해 접근 가능한 NLB를 생성합니다.
# Creates an Internet-facing Network Load Balancer (NLB).
resource "aws_lb" "internet_nlb" {
  name               = "${var.stack_name}-InternetNLB" # NLB 이름 / NLB name
  internal           = false                           # 외부에서 접근 가능 / External access enabled
  load_balancer_type = "network"                       # NLB 유형 / NLB type
  subnets            = var.public_subnets             # NLB를 배치할 퍼블릭 서브넷 / Public subnets for NLB placement

  # 태그 설정 / Tag configuration
  tags = merge(
    var.common_tags,
    {
      Name = "${var.stack_name}-InternetNLB" # NLB 리소스 이름 태그 / NLB resource name tag
    }
  )
}

# NLB Listener (TCP) / NLB 리스너 (TCP)
# NLB에 TCP 리스너를 추가합니다.
# Adds a TCP listener to the NLB.
resource "aws_lb_listener" "nlb_public_listener" {
  load_balancer_arn = aws_lb.internet_nlb.arn         # NLB ARN / NLB ARN
  port              = 80                              # TCP 포트 / TCP port
  protocol          = "TCP"                           # 프로토콜 / Protocol

  # 기본 동작으로 트래픽을 타겟 그룹으로 전달 / Default action forwards traffic to the target group
  default_action {
    target_group_arn = aws_lb_target_group.nlb_public_target_group.arn # 타겟 그룹 ARN / Target group ARN
    type             = "forward"                                      # 포워드 동작 / Forward action
  }
}

# NLB Target Group / NLB 타겟 그룹
# NLB의 트래픽을 EC2 인스턴스에 전달하는 타겟 그룹을 생성합니다.
# Creates a target group for NLB to forward traffic to EC2 instances.
resource "aws_lb_target_group" "nlb_public_target_group" {
  name     = "${var.stack_name}-NLB-PublicTargetGroup" # 타겟 그룹 이름 / Target group name
  port     = 80                                       # TCP 포트 / TCP port
  protocol = "TCP"                                    # 프로토콜 / Protocol
  vpc_id   = var.vpc_id                               # VPC ID

  # 헬스 체크 설정 / Health check configuration
  health_check {
    protocol            = "TCP"                      # 헬스 체크 프로토콜 / Health check protocol
    healthy_threshold   = 3                          # 건강 상태 임계값 / Healthy threshold
    unhealthy_threshold = 2                          # 비정상 상태 임계값 / Unhealthy threshold
    interval            = 30                         # 헬스 체크 간격 / Health check interval
  }

  # 태그 설정 / Tag configuration
  tags = merge(
    var.common_tags,
    {
      Name = "${var.stack_name}-NLB-PublicTargetGroup" # 타겟 그룹 이름 태그 / Target group name tag
    }
  )
}

# Target 등록 / Register targets
# EC2 인스턴스를 NLB 타겟 그룹에 추가합니다.
# Add EC2 instances to the NLB target group.
resource "aws_lb_target_group_attachment" "private_instance_1" {
  target_group_arn = aws_lb_target_group.nlb_public_target_group.arn # 타겟 그룹 ARN / Target group ARN
  target_id        = var.private_instance_1_id                       # 프라이빗 인스턴스 1 ID / Private instance 1 ID
  port             = 80                                              # TCP 포트 / TCP port
}

resource "aws_lb_target_group_attachment" "private_instance_2" {
  target_group_arn = aws_lb_target_group.nlb_public_target_group.arn # 타겟 그룹 ARN / Target group ARN
  target_id        = var.private_instance_2_id                       # 프라이빗 인스턴스 2 ID / Private instance 2 ID
  port             = 80                                              # TCP 포트 / TCP port
}