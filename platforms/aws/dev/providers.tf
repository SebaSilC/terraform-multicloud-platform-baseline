provider "aws" {
  region = var.context.region

  default_tags {
    tags = {
      Environment = var.context.environment
      Platform    = var.context.platform
      ManagedBy   = "Terraform"
    }
  }
}
