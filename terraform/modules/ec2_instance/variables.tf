# modules/ec2_instance/variables.tf

variable "subnet_id" {
  description = "List of subnet IDs where EC2 instances will be launched"
}


variable "security_group_id" {
  description = "ID of the security group to attach to the EC2 instance"
}

variable "key_name" {
  description = "Name of the key pair to use for SSH access"
}

variable "ami_id" {
  description = "ID of the AMI to use for the EC2 instance"
}

variable "instance_type" {
  description = "Type of EC2 instance"
}
variable "public_instance_status" {
  description = "A simple variable"
  type        = number
  default     = 0 # Default value can be any number
}
