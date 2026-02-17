variable "environment" {
  description = "Deployment environment"
  type        = string
}

variable "log_retention_days" {
  description = "Retention period for logs"
  type        = number
  default     = 90
}
