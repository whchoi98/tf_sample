# 인터넷을 통한 Application Load Balancer / Internet-facing Application Load Balancer
# 인터넷에서 접근 가능한 ALB를 정의합니다. / Defines an ALB accessible from the internet.
resource "aws_lb" "internet_alb" {
  name               = "${var.stack_name}-InternetALB" # ALB 이름 / ALB name
  internal           = false                           # 외부에서 접근 가능 / External access enabled
  load_balancer_type = "application"                   # ALB 유형 / ALB type
  security_groups   = [var.alb_security_group_id]      # ALB에 적용할 보안 그룹 / Security group for the ALB
  subnets            = var.public_subnets              # 퍼블릭 서브넷에 배치 / Deployed in public subnets

  enable_deletion_protection = false                   # 삭제 보호 비활성화 / Deletion protection disabled
  idle_timeout {
    timeout_seconds = 60                               # 비활성화 시간 초과 설정 / Idle timeout setting
  }

  # ALB 리소스에 태그 추가 / Add tags to the ALB resource
  tags = merge(var.common_tags, {
    Name = "${var.stack_name}-InternetALB"             # 리소스 이름 태그 / Resource name tag
  })
}

# ALB Listener (Public) / ALB 리스너 (퍼블릭)
# ALB의 퍼블릭 리스너를 정의합니다. / Defines a public listener for the ALB.
resource "aws_lb_listener" "alb_public_listener" {
  load_balancer_arn = aws_lb.internet_alb.arn          # ALB ARN / ALB ARN
  port              = 80                               # HTTP 포트 / HTTP port
  protocol          = "HTTP"                           # HTTP 프로토콜 / HTTP protocol

  # 기본 동작으로 타겟 그룹으로 트래픽 전달 / Default action forwards traffic to the target group
  default_action {
    target_group_arn = aws_lb_target_group.alb_public_target_group.arn # 타겟 그룹 ARN / Target group ARN
    type             = "forward"                                      # 트래픽 포워딩 / Forwarding traffic
  }
}

# ALB Target Group (Private EC2) / ALB 타겟 그룹 (프라이빗 EC2)
# 프라이빗 EC2 인스턴스를 대상으로 하는 ALB 타겟 그룹을 정의합니다. / Defines an ALB target group for private EC2 instances.
resource "aws_lb_target_group" "alb_public_target_group" {
  name     = "${var.stack_name}-ALB-PublicTargetGroup" # 타겟 그룹 이름 / Target group name
  port     = 80                                       # HTTP 포트 / HTTP port
  protocol = "HTTP"                                   # HTTP 프로토콜 / HTTP protocol
  vpc_id   = var.vpc_id                               # VPC ID

  # 헬스 체크 설정 / Health check settings
  health_check {
    protocol            = "HTTP"                     # 헬스 체크 프로토콜 / Health check protocol
    path                = "/ec2meta-webpage/index.php" # 헬스 체크 경로 / Health check path
    healthy_threshold   = 5                          # 건강 상태 임계값 / Healthy threshold
    unhealthy_threshold = 2                          # 비정상 상태 임계값 / Unhealthy threshold
    timeout_seconds     = 5                          # 타임아웃 초 / Timeout in seconds
    interval_seconds    = 30                         # 헬스 체크 간격 / Health check interval
    success_codes       = "200"                      # 성공 코드 / Success code
  }

  # 타겟 그룹 리소스에 태그 추가 / Add tags to the target group resource
  tags = merge(var.common_tags, {
    Name = "${var.stack_name}-ALB-PublicTargetGroup"  # 리소스 이름 태그 / Resource name tag
  })

  # 타겟 그룹 속성 설정 / Configure target group attributes
  target_group_attributes {
    key   = "deregistration_delay.timeout_seconds"    # 타겟 해제 지연 시간 초 / Deregistration delay in seconds
    value = "300"
  }

  target_group_attributes {
    key   = "stickiness.enabled"                     # 세션 스티키니스 활성화 / Enable session stickiness
    value = "false"                                  # 비활성화 / Disabled
  }

  target_group_attributes {
    key   = "stickiness.type"                        # 스티키니스 유형 / Stickiness type
    value = "lb_cookie"                              # 로드 밸런서 쿠키 / Load balancer cookie
  }

  target_group_attributes {
    key   = "stickiness.lb_cookie.duration_seconds"  # 스티키니스 지속 시간 / Stickiness duration
    value = "86400"                                  # 하루 지속 / 1 day duration
  }

  # 프라이빗 EC2 인스턴스를 대상으로 트래픽 전달 / Forward traffic to private EC2 instances
  targets {
    id   = var.private_instance_1_id                 # 프라이빗 인스턴스 1 ID / Private instance 1 ID
    port = 80                                        # HTTP 포트 / HTTP port
  }

  targets {
    id   = var.private_instance_2_id                 # 프라이빗 인스턴스 2 ID / Private instance 2 ID
    port = 80                                        # HTTP 포트 / HTTP port
  }
}