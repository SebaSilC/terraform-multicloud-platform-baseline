locals {
  base_tags = {
    Environment = var.environment
    Project     = var.project
    ManagedBy   = "Terraform"
  }

  merged_tags = merge(local.base_tags, var.additional_tags)
}
