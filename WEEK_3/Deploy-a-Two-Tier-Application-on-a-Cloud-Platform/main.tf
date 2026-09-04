#############################################
# Networking
#############################################
module "vpc" {
  source = "./modules/vpc"

  project_name         = var.project_name
  vpc_cidr             = var.vpc_cidr
  public_subnet_cidr   = var.public_subnet_cidr
  private_subnet_cidrs = var.private_subnet_cidrs
  availability_zones   = var.availability_zones
  tags                 = var.tags
}

#############################################
# Security Groups
#############################################
module "security" {
  source = "./modules/security"

  project_name = var.project_name
  vpc_id       = module.vpc.vpc_id
  my_ip_cidr   = var.my_ip_cidr
  db_port      = var.db_port
  tags         = var.tags
}

#############################################
# Compute (Nginx web server, public subnet)
#############################################
module "compute" {
  source = "./modules/compute"

  project_name       = var.project_name
  instance_type      = var.instance_type
  public_subnet_id   = module.vpc.public_subnet_id
  security_group_id  = module.security.web_sg_id
  key_name           = var.key_name
  tags               = var.tags
}

#############################################
# Database (RDS, private subnet, no public access)
#############################################
module "database" {
  source = "./modules/database"

  project_name       = var.project_name
  private_subnet_ids = module.vpc.private_subnet_ids
  security_group_id  = module.security.db_sg_id

  engine            = var.db_engine
  engine_version    = var.db_engine_version
  instance_class    = var.db_instance_class
  allocated_storage = var.db_allocated_storage

  db_name     = var.db_name
  db_username = var.db_username
  db_password = var.db_password

  backup_retention_period = var.db_backup_retention_period

  tags = var.tags
}
