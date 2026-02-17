variable "environment" {
  description = "Deployment environment"
  type        = string
}

variable "admin_principal_arns" {
  description = "ARNs allowed to assume break-glass role"
  type        = list(string)
}

variable "read_only_principal_arns" {
  description = "ARNs allowed to assume read-only role"
  type        = list(string)
}
