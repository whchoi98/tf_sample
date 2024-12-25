# SSM Role for EC2
resource "aws_iam_role" "ssm_role" {
  name               = "${var.name}-SSMRole"
  path               = "/"
  managed_policy_arns = [
    "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  ]

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })

  tags = merge(
    var.common_tags,
    {
      Name = "${var.environment}-${var.name}-SSMRole"
    }
  )
}

# Instance Profile for SSM Role
resource "aws_iam_instance_profile" "ssm_instance_profile" {
  name = "${var.name}-SSMInstanceProfile"
  path = "/"
  role = aws_iam_role.ssm_role.name

  tags = merge(
    var.common_tags,
    {
      Name = "${var.environment}-${var.name}-InstanceProfile"
    }
  )
}