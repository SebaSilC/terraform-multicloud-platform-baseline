module "tags" {
  source = "../../../modules/tagging"

  environment = var.context.environment
  project     = var.context.platform
}

module "networking" {
  source = "../../../modules/aws-network"

  config      = var.network
  environment = var.context.environment
  tags        = module.tags.tags
}

module "iam" {
  source = "../../../modules/aws-iam-baseline"

  environment = var.context.environment

  admin_principal_arns     = var.iam.admin_principal_arns
  read_only_principal_arns = var.iam.read_only_principal_arns
}

module "audit_logging" {
  source = "../../../modules/aws-logging-baseline"

  environment = var.context.environment
  tags        = module.tags.tags
}
