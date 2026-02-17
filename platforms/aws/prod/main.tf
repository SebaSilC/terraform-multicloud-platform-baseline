locals {
  project_name = "multicloud-platform-baseline"
}

module "network" {
  source = "../../../modules/aws-network"

  vpc_cidr             = "10.2.0.0/16"
  public_subnet_cidrs  = ["10.2.1.0/24", "10.2.2.0/24"]
  private_subnet_cidrs = ["10.2.10.0/24", "10.2.20.0/24"]
  availability_zones   = ["eu-central-1a", "eu-central-1b"]
  environment          = var.environment
}

module "iam_baseline" {
  source = "../../../modules/aws-iam-baseline"

  environment = var.environment

  admin_principal_arns = [
    "arn:aws:iam::<your-account-id>:root"
  ]

  read_only_principal_arns = [
    "arn:aws:iam::<your-account-id>:root"
  ]
}

module "logging_baseline" {
  source = "../../../modules/aws-logging-baseline"

  environment = var.environment
}
