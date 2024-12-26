# Output: NLB DNS 이름 / NLB DNS Name
# 생성된 NLB의 DNS 이름을 출력합니다.
# Outputs the DNS name of the created NLB.
output "nlb_dns_name" {
  value = aws_lb.internet_nlb.dns_name # NLB의 DNS 이름 / NLB DNS name
}

# Output: NLB ARN / NLB ARN
# 생성된 NLB의 ARN을 출력합니다.
# Outputs the ARN of the created NLB.
output "nlb_arn" {
  value = aws_lb.internet_nlb.arn # NLB의 ARN / NLB ARN
}