# # main.tf

# Define the VPC module
module "vpc" {
  source         = "./modules/vpc_module"
  vpc_cidr_block = var.vpc_cidr_block # Pass the variable to the module
  environment    = var.environment
  owner          = var.owner
}


# Define the subnet module
module "subnets" {
  source               = "./modules/subnets"
  vpc_id               = module.vpc.vpc_id
  vpc_cidr_block       = var.vpc_cidr_block
  private_subnet_names = var.private_subnet_name # List of public subnet names
}

module "igw" {
  source                = "./modules/internet_gateway"
  vpc_id                = module.vpc.vpc_id
  internet_gateway_name = var.internet_gateway_name
}

module "route_table" {
  source = "./modules/route_table"
  vpc_id                   = module.vpc.vpc_id                 # Assuming you have already created the VPC
  internet_gateway_id      = module.igw.internet_gateway_id    # Assuming you have already created the internet gateway
  public_subnet_ids        = module.subnets.public_subnet_ids  # Using the output from subnet module
  private_subnet_ids       = module.subnets.private_subnet_ids # Using the output from subnet module
  public_route_table_name  = "public-route-table"
  private_route_table_name = "private-route-table"
  nat_gateway_id           = module.nat_gateway.nat_gateway_id[0] # Pass NAT Gateway ID to route_table module
}

module "security_group" {
  source                     = "./modules/security_group"
  vpc_id                     = module.vpc.vpc_id # Assuming you have already created the VPC
  security_group_name        = "example-security-group"
  security_group_description = "Example security group allowing ports 80, 4000, 8080, 9000, 443"
}

# Define EC2 Public Instance
module "ec2_public_instance" {
  source                 = "./modules/ec2_instance"
  subnet_id              = module.subnets.public_subnet_ids
  security_group_id      = module.security_group.security_group_id
  key_name               = var.key_name
  ami_id                 = var.ami_id
  instance_type          = var.instance_type
  public_instance_status = 0
}

# Define EC2 Private Instance
module "ec2_private_instance" {
  source                 = "./modules/ec2_instance"
  subnet_id              = module.subnets.private_subnet_ids
  security_group_id      = module.security_group.security_group_id
  key_name               = var.key_name
  ami_id                 = var.ami_id
  instance_type          = var.instance_type
  public_instance_status = 1
}


# Use the Elastic IP module
module "elastic_ip" {
  source = "./modules/elastic_ip"
}

# main.tf

module "nat_gateway" {
  source           = "./modules/nat_gateway"
  allocation_id    = module.elastic_ip.elastic_ip_allocation_id
  subnet_id        = module.subnets.public_subnet_ids
  nat_gateway_name = "my-nat-gateway"
}
