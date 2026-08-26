# -----------------------------------------------------
# VPC Module
# -----------------------------------------------------
module "vpc" {
  source = "./modules/vpc"

  project_name = var.project_name
  vpc_cidr     = var.vpc_cidr
}

# -----------------------------------------------------
# Networking Module (subnet, IGW, route table)
# -----------------------------------------------------
module "networking" {
  source = "./modules/networking"

  project_name        = var.project_name
  vpc_id              = module.vpc.vpc_id
  public_subnet_cidr  = var.public_subnet_cidr
  availability_zone   = var.availability_zone
}

# -----------------------------------------------------
# Security Module (security group)
# -----------------------------------------------------
module "security" {
  source = "./modules/security"

  project_name     = var.project_name
  vpc_id           = module.vpc.vpc_id
  ssh_allowed_cidr = var.ssh_allowed_cidr
}

# -----------------------------------------------------
# Compute Module (EC2 instance running Nginx)
# -----------------------------------------------------
module "compute" {
  source = "./modules/compute"

  project_name       = var.project_name
  subnet_id          = module.networking.public_subnet_id
  security_group_id  = module.security.security_group_id
  instance_type      = var.instance_type
  key_name           = var.key_name
  full_name          = var.full_name
  event_name         = var.event_name
}
