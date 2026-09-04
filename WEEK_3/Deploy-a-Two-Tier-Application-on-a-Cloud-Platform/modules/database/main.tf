#############################################
# DB Subnet Group (spans the private subnets)
#############################################
resource "aws_db_subnet_group" "main" {
  name       = "${var.project_name}-db-subnet-group"
  subnet_ids = var.private_subnet_ids

  tags = merge(var.tags, {
    Name = "${var.project_name}-db-subnet-group"
  })
}

#############################################
# RDS Instance - private subnet, no public access
#############################################
resource "aws_db_instance" "main" {
  identifier     = "${var.project_name}-db"
  engine         = var.engine
  engine_version = var.engine_version
  instance_class = var.instance_class

  allocated_storage = var.allocated_storage
  storage_type      = "gp3"
  storage_encrypted = true

  db_name  = var.db_name
  username = var.db_username
  password = var.db_password

  db_subnet_group_name   = aws_db_subnet_group.main.name
  vpc_security_group_ids = [var.security_group_id]

  # Security requirements: private subnet only, never publicly accessible
  publicly_accessible = false
  multi_az            = var.multi_az

  skip_final_snapshot = var.skip_final_snapshot
  final_snapshot_identifier = var.skip_final_snapshot ? null : "${var.project_name}-db-final-snapshot"

  backup_retention_period = var.backup_retention_period

  tags = merge(var.tags, {
    Name = "${var.project_name}-db"
  })
}
