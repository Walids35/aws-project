# variables.tf

variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
}

variable "private_subnet_name" {
  description = "List of names for private subnets"
  type        = list(string)
}

variable "environment" {
  description = "Environment tag value"
}

variable "owner" {
  description = "Owner tag value"
}

variable "ami_id" {
  description = "AMI ID for the instances"
}

variable "instance_type" {
  description = "Instance type for the instances"
}


variable "internet_gateway_name" {
  description = "Name of the internet gateway"
}
variable "key_name" {
  description = "Name of the key pair to use for SSH access"
}


variable "nat_gateway_name" {
  description = "Name of the nat gateway"
}


variable "region" {
  description = "Name of the region"
}
