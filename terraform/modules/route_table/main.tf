resource "aws_route_table" "public_route_table" {
  vpc_id = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.internet_gateway_id
  }

  tags = {
    Name = var.public_route_table_name
  }
}

# Define Route for Private Route Table (assuming NAT Gateway for internet access)
resource "aws_route_table" "private_route_table" {
  vpc_id = var.vpc_id
  tags = {
    nat_gateway_enabled = true
    Name                = var.private_route_table_name


  }
}
# Define Default Route for Private Route Table (pointing to NAT Gateway)
resource "aws_route" "private_default_route" {
  route_table_id         = aws_route_table.private_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = var.nat_gateway_id # Use the NAT Gateway ID variable passed from the main module
}

resource "aws_route_table_association" "public_subnet_association" {
  count = length(var.public_subnet_ids)

  subnet_id      = var.public_subnet_ids[count.index]
  route_table_id = aws_route_table.public_route_table.id
}


# Associate Private Subnets with Private Route Table
resource "aws_route_table_association" "private_subnet_association" {
  count          = length(var.private_subnet_ids)
  subnet_id      = var.private_subnet_ids[count.index]
  route_table_id = aws_route_table.private_route_table.id
}
