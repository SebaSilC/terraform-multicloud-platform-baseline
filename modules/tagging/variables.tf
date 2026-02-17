variable "environment" {
  description = "Environment name"
  type        = string
}

variable "project" {
  description = "Project name"
  type        = string
}

variable "additional_tags" {
  description = "Additional custom tags"
  type        = map(string)
  default     = {}
}
