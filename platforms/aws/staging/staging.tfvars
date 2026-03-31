region      = "eu-central-1"
environment = "staging"
project     = "platform"

vpc_cidr             = "10.1.0.0/16"
public_subnet_cidrs  = ["10.1.1.0/24", "10.1.2.0/24"]
private_subnet_cidrs = ["10.1.10.0/24", "10.1.20.0/24"]
availability_zones   = ["eu-central-1a", "eu-central-1b"]

admin_principal_arns = [
  "arn:aws:iam::123456789012:root"
]

read_only_principal_arns = [
  "arn:aws:iam::123456789012:root"
]
