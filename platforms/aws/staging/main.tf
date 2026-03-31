module "tags" {
  source = "../../../modules/tagging"

  environment = var.environment
  project     = var.project
}

module "network" {
  source = "../../../modules/aws-network"

  vpc_cidr             = var.vpc_cidr
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  availability_zones   = var.availability_zones
  environment          = var.environment

  tags = module.tags.tags
}

module "iam_baseline" {
  source = "../../../modules/aws-iam-baseline"

  environment = var.environment

  admin_principal_arns     = var.admin_principal_arns
  read_only_principal_arns = var.read_only_principal_arns
}

module "logging_baseline" {
  source = "../../../modules/aws-logging-baseline"

  environment = var.environment
  tags        = module.tags.tags
}
