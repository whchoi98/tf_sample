# 퍼블릭 서브넷 EC2 인스턴스 / Public Subnet EC2 Instances
# 퍼블릭 서브넷에 고정된 IP 목록을 기반으로 EC2 인스턴스를 생성합니다.
# Creates EC2 instances in public subnets based on a fixed list of IPs.
resource "aws_instance" "public_ec2" {
  count         = length(var.public_fixed_ips) # 고정된 IP 목록 개수만큼 EC2 인스턴스 생성 / Creates EC2 instances for each fixed IP
  ami           = var.ami_id                  # Amazon Linux 2 AMI ID
  instance_type = var.instance_type           # EC2 인스턴스 타입 / EC2 instance type
  iam_instance_profile = var.instance_profile
  subnet_id     = element(var.public_subnet_ids, count.index / 2)
  # 각 퍼블릭 서브넷에 인스턴스를 분배 / Distributes instances across public subnets
  private_ip    = var.public_fixed_ips[count.index] 
  # 고정된 IP를 사용하여 EC2 설정 / Configures EC2 with fixed IPs

  # 퍼블릭 EC2에 보안 그룹 연결 / Associates security group for public EC2
  vpc_security_group_ids = [var.public_ec2_security_group_id]

  # 리소스 태그 설정 / Resource tags configuration
  tags = merge(
    var.common_tags, 
    {
      Name = "${var.environment}-Public-${var.public_fixed_ips[count.index]}" # 환경 기반 이름 생성 / Generates name based on environment
    }
  )

  # IAM Instance Profile 연결 / Associates IAM Instance Profile

  # User Data 스크립트 / User Data script
  # EC2 인스턴스에 Apache HTTP 서버 및 기타 도구를 설치 / Installs Apache HTTP server and other tools on the EC2 instance
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

# 프라이빗 서브넷 EC2 인스턴스 / Private Subnet EC2 Instances
# 프라이빗 서브넷에 고정된 IP 목록을 기반으로 EC2 인스턴스를 생성합니다.
# Creates EC2 instances in private subnets based on a fixed list of IPs.
resource "aws_instance" "private_ec2" {
  count         = length(var.private_fixed_ips) # 고정된 IP 목록 개수만큼 EC2 인스턴스 생성 / Creates EC2 instances for each fixed IP
  ami           = var.ami_id                   # Amazon Linux 2 AMI ID
  instance_type = var.instance_type            # EC2 인스턴스 타입 / EC2 instance type
  iam_instance_profile = var.instance_profile
  subnet_id     = element(var.public_subnet_ids, count.index / 2)
  # 각 프라이빗 서브넷에 인스턴스를 분배 / Distributes instances across private subnets
  private_ip    = var.private_fixed_ips[count.index] 
  # 고정된 IP를 사용하여 EC2 설정 / Configures EC2 with fixed IPs

  # 프라이빗 EC2에 보안 그룹 연결 / Associates security group for private EC2
  vpc_security_group_ids = [var.private_ec2_security_group_id]

  # 리소스 태그 설정 / Resource tags configuration
  tags = merge(
    var.common_tags, 
    {
      Name = "${var.environment}-Private-${var.private_fixed_ips[count.index]}" # 환경 기반 이름 생성 / Generates name based on environment
    }
  )

  # User Data 스크립트 / User Data script
  # EC2 인스턴스에 Apache HTTP 서버 및 기타 도구를 설치 / Installs Apache HTTP server and other tools on the EC2 instance
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