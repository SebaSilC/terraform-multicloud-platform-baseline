provider "aws" {
  region = var.region

  default_tags {
    tags = {
      Environment = var.environment
      Project     = "multicloud-platform-baseline"
      ManagedBy   = "Terraform"
    }
  }
}
