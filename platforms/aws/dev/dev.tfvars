context = {
  environment = "dev"
  region      = "eu-central-1"
  platform    = "platform"
}

network = {
  vpc_cidr             = "10.10.0.0/16"
  public_subnet_cidrs  = ["10.10.1.0/24", "10.10.2.0/24"]
  private_subnet_cidrs = ["10.10.10.0/24", "10.10.20.0/24"]
  availability_zones   = ["eu-central-1a", "eu-central-1b"]
}

iam = {
  admin_principal_arns = [
    "arn:aws:iam::123456789012:root"
  ]

  read_only_principal_arns = [
    "arn:aws:iam::123456789012:root"
  ]
}
