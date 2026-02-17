variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "public_subnet_cidrs" {
  description = "Public subnet CIDRs"
  type        = list(string)
}

variable "private_subnet_cidrs" {
  description = "Private subnet CIDRs"
  type        = list(string)
}

variable "availability_zones" {
  description = "Availability zones"
  type        = list(string)
}

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "flow_log_retention_days" {
  description = "Retention period for VPC Flow Logs"
  type        = number
  default     = 30
}

variable "tags" {
  description = "Common resource tags"
  type        = map(string)
}
