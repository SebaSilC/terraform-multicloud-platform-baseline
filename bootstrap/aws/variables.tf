variable "region" {
  description = "AWS region for bootstrap resources"
  type        = string
}

variable "state_bucket_name" {
  description = "S3 bucket name for Terraform state"
  type        = string
}

variable "lock_table_name" {
  description = "DynamoDB table for Terraform state locking"
  type        = string
}
