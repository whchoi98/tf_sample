resource "aws_instance" "ec2" {
  count         = length(var.fixed_ips)
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = element(var.subnet_ids, count.index % length(var.subnet_ids))
  private_ip    = var.fixed_ips[count.index]
  key_name      = var.key_pair
  iam_instance_profile = var.instance_profile
  security_groups      = [var.security_group_id]

  tags = merge(
    var.common_tags,
    {
      Name = "${var.environment}-${var.subnet_type}-${var.fixed_ips[count.index]}"
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