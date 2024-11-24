# Define the VPC
resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr_block # Accessing the variable defined in the module
  tags = {
    Name        = "my-vpc"
    Environment = var.environment
    Owner       = var.owner
  }
}

