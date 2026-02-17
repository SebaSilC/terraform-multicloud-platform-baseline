resource "aws_vpc" "this" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name        = "${var.environment}-vpc"
    Environment = var.environment
  }
}

resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id

  tags = {
    Name = "${var.environment}-igw"
  }
}

resource "aws_subnet" "public" {
  for_each = zipmap(var.public_subnet_cidrs, var.availability_zones)

  vpc_id                  = aws_vpc.this.id
  cidr_block              = each.key
  availability_zone       = each.value
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.environment}-public-${each.value}"
  }
}

resource "aws_subnet" "private" {
  for_each = zipmap(var.private_subnet_cidrs, var.availability_zones)

  vpc_id            = aws_vpc.this.id
  cidr_block        = each.key
  availability_zone = each.value

  tags = {
    Name = "${var.environment}-private-${each.value}"
  }
}

resource "aws_eip" "nat" {
  domain = "vpc"
}

resource "aws_nat_gateway" "this" {
  allocation_id = aws_eip.nat.id
  subnet_id     = values(aws_subnet.public)[0].id

  tags = {
    Name = "${var.environment}-nat"
  }
}
