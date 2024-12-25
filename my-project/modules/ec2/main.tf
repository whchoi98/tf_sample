# Public Subnet EC2 Instances
resource "aws_instance" "public_ec2" {
  count         = length(var.public_fixed_ips) # Public Subnet에 고정된 IP 목록의 개수만큼 EC2 생성
  ami           = var.ami_id                  # AMI ID (Amazon Linux 2)
  instance_type = var.instance_type           # 인스턴스 타입
  subnet_id     = element(var.public_subnet_ids, count.index % length(var.public_subnet_ids))
  private_ip    = var.public_fixed_ips[count.index]

  # Public EC2 Security Group 연결
  security_group_ids = [var.public_ec2_security_group_id]

  # 태그 및 이름 설정
  tags = merge(
    var.common_tags,
    {
      Name = "${var.environment}-Public-${var.public_fixed_ips[count.index]}"
    }
  )

  # IAM Instance Profile 연결
  iam_instance_profile = var.instance_profile  # IAM 인스턴스 프로필 연결

  # User Data 스크립트
  user_data = <<-EOF
    #!/bin/bash
    sudo yum -y update
    sudo yum -y install yum-utils 
    sudo yum -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
    sudo yum -y install iotop iperf3 iptraf tcpdump git bash-completion 
    sudo yum -y install httpd php mysql php-mysql 
    sudo yum -y install python-pip
    sudo yum -y install nethogs iftop lnav nmon tmux wireshark vsftpd ftp nc
    sudo systemctl start httpd
    sudo systemctl enable httpd
    cd /var/www/html/
    sudo git clone https://github.com/whchoi98/ec2meta-webpage.git
    sudo systemctl restart httpd
    exit
  EOF
}

# Private Subnet EC2 Instances
resource "aws_instance" "private_ec2" {
  count         = length(var.private_fixed_ips) # Private Subnet에 고정된 IP 목록의 개수만큼 EC2 생성
  ami           = var.ami_id                   # AMI ID (Amazon Linux 2)
  instance_type = var.instance_type            # 인스턴스 타입
  subnet_id     = element(var.private_subnet_ids, count.index % length(var.private_subnet_ids))
  private_ip    = var.private_fixed_ips[count.index]

  # Private EC2 Security Group 연결
  security_group_ids = [var.private_ec2_security_group_id]

  # 태그 및 이름 설정
  tags = merge(
    var.common_tags,
    {
      Name = "${var.environment}-Private-${var.private_fixed_ips[count.index]}"
    }
  )

  # IAM Instance Profile 연결
  iam_instance_profile = var.instance_profile  # IAM 인스턴스 프로필 연결

  # User Data 스크립트
  user_data = <<-EOF
    #!/bin/bash
    sudo yum -y update
    sudo yum -y install yum-utils 
    sudo yum -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
    sudo yum -y install iotop iperf3 iptraf tcpdump git bash-completion 
    sudo yum -y install httpd php mysql php-mysql 
    sudo yum -y install python-pip
    sudo yum -y install nethogs iftop lnav nmon tmux wireshark vsftpd ftp nc
    sudo systemctl start httpd
    sudo systemctl enable httpd
    cd /var/www/html/
    sudo git clone https://github.com/whchoi98/ec2meta-webpage.git
    sudo systemctl restart httpd
    exit
  EOF
}