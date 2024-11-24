# Define the public subnet
resource "aws_subnet" "public_subnet" {
  vpc_id                  = var.vpc_id
  cidr_block              = cidrsubnet(var.vpc_cidr_block, 8, 0)
  map_public_ip_on_launch = true

  tags = {
    Name = "public-subnet"

  }
}

# Define the private subnets for the application and data tiers
resource "aws_subnet" "private_subnet" {
  count = length(var.private_subnet_names) # Length of the list of private subnet names

  vpc_id     = var.vpc_id
  cidr_block = cidrsubnet(var.vpc_cidr_block, 8, length(var.private_subnet_names) + count.index)

  tags = {
    Name = var.private_subnet_names[count.index]

  }
}
