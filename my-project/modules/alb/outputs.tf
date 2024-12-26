# ALB DNS 이름 출력 / Output ALB DNS Name
# 생성된 ALB의 DNS 이름을 출력합니다. / Outputs the DNS name of the created ALB.
output "alb_dns_name" {
  value = aws_lb.internet_alb.dns_name # ALB DNS 이름 / ALB DNS name
}

# ALB ARN 출력 / Output ALB ARN
# 생성된 ALB의 ARN을 출력합니다. / Outputs the ARN of the created ALB.
output "alb_arn" {
  value = aws_lb.internet_alb.arn # ALB ARN
}