# nat_gateway/main.tf

resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = var.allocation_id
  count         = length(var.subnet_id)
  subnet_id     = var.subnet_id[count.index]

  tags = {
    Name = var.nat_gateway_name

  }
  # depends_on = [module.elastic_ip]
}
