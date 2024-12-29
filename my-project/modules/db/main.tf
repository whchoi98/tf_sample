# Aurora MySQL DB Subnet Group
resource "aws_db_subnet_group" "aurora" {
  name       = "${var.name}-aurora-db-subnet-group" # Subnet Group 이름
  subnet_ids = var.db_subnet_ids

  tags = merge(
    var.common_tags,
    {
      Name = "${var.name}-aurora-db-subnet-group"
    }
  )
}

# Aurora MySQL DB Cluster
resource "aws_rds_cluster" "aurora" {
  cluster_identifier      = "${var.name}-aurora-cluster"
  engine                  = "aurora-mysql"
  engine_version          = var.engine_version
  database_name           = var.database_name
  master_username         = var.master_username
  master_password         = var.master_password
  backup_retention_period = var.backup_retention_period
  preferred_backup_window = var.preferred_backup_window
  db_subnet_group_name    = aws_db_subnet_group.aurora.name # DB Subnet Group 참조
  vpc_security_group_ids  = var.vpc_security_group_ids
  storage_encrypted       = true
  apply_immediately       = true

  tags = merge(
    var.common_tags,
    {
      Name = "${var.name}-aurora-cluster"
    }
  )
}

# Aurora MySQL DB Cluster Instances
resource "aws_rds_cluster_instance" "aurora_instances" {
  count                   = var.instance_count
  identifier              = "${var.name}-aurora-instance-${count.index + 1}"
  cluster_identifier      = aws_rds_cluster.aurora.id
  instance_class          = var.instance_class
  publicly_accessible     = var.publicly_accessible
  engine                  = aws_rds_cluster.aurora.engine
  engine_version          = aws_rds_cluster.aurora.engine_version
  apply_immediately       = true

  tags = merge(
    var.common_tags,
    {
      Name = "${var.name}-aurora-instance-${count.index + 1}"
    }
  )
}

# RDS 클러스터 인스턴스 / RDS Cluster Instances
resource "aws_rds_cluster_instance" "instances" {
  count              = var.instance_count
  identifier         = "${var.name}-instance-${count.index + 1}" # 각 인스턴스 식별자 / Instance identifier
  cluster_identifier = aws_rds_cluster.aurora.id
  instance_class     = var.instance_class
  publicly_accessible = var.publicly_accessible
  engine             = "aurora-mysql"

  tags = merge(
    var.common_tags,
    {
      Name = "${var.name}-instance-${count.index + 1}"
    }
  )
}