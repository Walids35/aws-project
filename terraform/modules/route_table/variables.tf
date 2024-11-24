variable "vpc_id" {
  description = "ID of the VPC to associate the route table"
}

variable "internet_gateway_id" {
  description = "ID of the internet gateway for the default route"
}

variable "public_subnet_ids" {
  description = "List of IDs of public subnets to associate with the route table"
  type        = list(string)
}

variable "public_route_table_name" {
  description = "Name of the route table"
}

variable "private_subnet_ids" {
  description = "List of IDs of private subnets"
  type        = list(string)
}

variable "private_route_table_name" {
  description = "Name for the private route table"
}
variable "nat_gateway_id" {
  description = "Name of the key pair to use for SSH access"
}

