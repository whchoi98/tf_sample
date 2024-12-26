# EC2용 SSM 역할 / SSM Role for EC2
# EC2 인스턴스에서 SSM을 사용하기 위한 IAM 역할을 생성합니다.
# Creates an IAM role for EC2 instances to use SSM.
resource "aws_iam_role" "ssm_role" {
  name               = "${var.name}-SSMRole" # 역할 이름 / Role name
  path               = "/"                   # 역할 경로 / Role path

  # 역할 신뢰 정책 / Role trust policy
  # EC2 서비스가 이 역할을 사용할 수 있도록 설정합니다.
  # Allows the EC2 service to assume this role.
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow" # 허용 효과 / Allow effect
        Principal = {
          Service = "ec2.amazonaws.com" # EC2 서비스 / EC2 service
        }
        Action = "sts:AssumeRole" # 역할 수임 동작 / Assume role action
      }
    ]
  })

  # 태그 설정 / Tag configuration
  tags = merge(
    var.common_tags,
    {
      Name = "${var.environment}-${var.name}-SSMRole" # 역할 이름 태그 / Role name tag
    }
  )
}

# SSM 정책 연결 / Attach SSM Policy
# SSM 정책을 IAM 역할에 연결합니다.
# Attaches the SSM policy to the IAM role.
resource "aws_iam_role_policy_attachment" "ssm_policy_attachment" {
  role       = aws_iam_role.ssm_role.name # 연결할 역할 이름 / Role to attach
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore" # SSM 정책 ARN / SSM policy ARN
}

# SSM 역할용 인스턴스 프로파일 / Instance Profile for SSM Role
# SSM 역할과 연결된 IAM 인스턴스 프로파일을 생성합니다.
# Creates an IAM instance profile associated with the SSM role.
resource "aws_iam_instance_profile" "ssm_instance_profile" {
  name = "${var.name}-SSMInstanceProfile" # 인스턴스 프로파일 이름 / Instance profile name
  path = "/"                              # 프로파일 경로 / Profile path
  role = aws_iam_role.ssm_role.name       # 연결된 IAM 역할 이름 / Associated IAM role name

  # 태그 설정 / Tag configuration
  tags = merge(
    var.common_tags,
    {
      Name = "${var.environment}-${var.name}-InstanceProfile" # 인스턴스 프로파일 이름 태그 / Instance profile name tag
    }
  )
}

# SSM 역할 정책 연결 / Attach SSM Role Policy
resource "aws_iam_role_policy_attachment" "ssm_role" {
  for_each = toset([
    "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore", # SSM 관리 정책 / SSM management policy
    "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"  # 추가 정책 / Additional policy
  ])

  role       = aws_iam_role.ssm_role.name # SSM 역할 이름 / SSM role name
  policy_arn = each.value                  # 정책 ARN / Policy ARN
}