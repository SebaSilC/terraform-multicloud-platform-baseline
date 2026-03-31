variable "region" {
  description = "AWS region"
  type        = string
}

variable "environment" {
  description = "Deployment environment"
  type        = string

  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "environment must be one of: dev, staging, prod"
  }
}

variable "project" {
  description = "Project name"
  type        = string
}

variable "admin_principal_arns" {
  description = "Admin role principals"
  type        = list(string)
}

variable "read_only_principal_arns" {
  description = "Read-only role principals"
  type        = list(string)
}
