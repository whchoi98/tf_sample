# Public Subnet EC2 Instances
resource "aws_instance" "public_ec2" {
  for_each = tomap({
    "10.0.1.11" = var.public_subnet_ids[0],
    "10.0.1.12" = var.public_subnet_ids[0],
    "10.0.2.11" = var.public_subnet_ids[1],
    "10.0.2.12" = var.public_subnet_ids[1],
    "10.0.3.11" = var.public_subnet_ids[2],
    "10.0.3.12" = var.public_subnet_ids[2]
  })

  ami           = var.ami_id
  instance_type = var.instance_type
  iam_instance_profile = var.instance_profile
  subnet_id     = each.value
  private_ip    = each.key

  vpc_security_group_ids = [var.public_ec2_security_group_id]

  tags = merge(
    var.common_tags,
    {
      Name = "${var.environment}-Public-${each.key}"
    }
  )

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
  for_each = tomap({
    "10.0.32.11" = var.private_subnet_ids[0],
    "10.0.32.12" = var.private_subnet_ids[0],
    "10.0.64.11" = var.private_subnet_ids[1],
    "10.0.64.12" = var.private_subnet_ids[1],
    "10.0.96.11" = var.private_subnet_ids[2],
    "10.0.96.12" = var.private_subnet_ids[2]
  })

  ami           = var.ami_id
  instance_type = var.instance_type
  iam_instance_profile = var.instance_profile
  subnet_id     = each.value
  private_ip    = each.key

  vpc_security_group_ids = [var.private_ec2_security_group_id]

  tags = merge(
    var.common_tags,
    {
      Name = "${var.environment}-Private-${each.key}"
    }
  )

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