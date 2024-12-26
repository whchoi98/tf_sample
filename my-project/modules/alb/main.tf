# 인터넷을 통한 Application Load Balancer / Internet-facing Application Load Balancer
# 외부에서 접근 가능한 ALB를 정의합니다. / Defines an ALB accessible from the internet.
resource "aws_lb" "internet_alb" {
  name               = "${var.stack_name}-InternetALB" # ALB 이름 / ALB name
  internal           = false                           # 외부에서 접근 가능 / External access enabled
  load_balancer_type = "application"                   # ALB 유형 / ALB type
  security_groups    = [var.alb_security_group_id]     # ALB에 적용할 보안 그룹 / Security group for the ALB
  subnets            = var.public_subnets              # 퍼블릭 서브넷에 배치 / Deployed in public subnets
  enable_deletion_protection = false                   # 삭제 보호 비활성화 / Deletion protection disabled
  idle_timeout               = 60                      # 대기 시간 초과 설정 (초 단위) / Idle timeout setting (in seconds)

  # 태그 설정 / Tag configuration
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
    healthy_threshold   = 5                          # 정상 상태 임계값 / Healthy threshold
    unhealthy_threshold = 2                          # 비정상 상태 임계값 / Unhealthy threshold
    interval            = 30                         # 헬스 체크 간격 (초) / Health check interval (in seconds)
    timeout             = 5                          # 타임아웃 (초) / Timeout (in seconds)
    matcher             = "200"                      # 성공 코드 / Success code
  }

  # 세션 스티키니스 설정 / Session stickiness settings
  stickiness {
    type            = "lb_cookie"                    # 스티키니스 유형 / Stickiness type
    cookie_duration = 86400                          # 지속 시간 (초) / Duration (in seconds)
  }

  # 태그 설정 / Tag configuration
  tags = merge(var.common_tags, {
    Name = "${var.stack_name}-ALB-PublicTargetGroup"  # 리소스 이름 태그 / Resource name tag
  })
}

# ALB 타겟 추가 (Private EC2 Instances) / Adding targets to ALB (Private EC2 Instances)
# 6개의 프라이빗 EC2 인스턴스를 동적으로 타겟 그룹에 등록합니다.
resource "aws_lb_target_group_attachment" "targets" {
  for_each          = toset(var.private_instance_ids) # 전달된 모든 인스턴스 ID 처리 / Process all instance IDs
  target_group_arn  = aws_lb_target_group.alb_public_target_group.arn
  target_id         = each.value
  port              = 80
}