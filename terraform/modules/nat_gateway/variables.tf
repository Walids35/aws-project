# nat_gateway/variables.tf

variable "allocation_id" {
  description = "The allocation ID of the Elastic IP to associate with the NAT gateway"
  type        = string
}

variable "subnet_id" {
  description = "The subnet ID in which to create the NAT gateway"
}

variable "nat_gateway_name" {
  description = "The name of the NAT gateway"
  type        = string
}

