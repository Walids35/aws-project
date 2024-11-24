resource "aws_instance" "ec2_instance" {
  count                       = length(var.subnet_id)      # Create an EC2 instance for each subnet
  subnet_id                   = var.subnet_id[count.index] # Access subnet ID based on index
  vpc_security_group_ids      = [var.security_group_id]
  key_name                    = var.key_name
  ami                         = var.ami_id
  instance_type               = var.instance_type
  associate_public_ip_address = var.public_instance_status == 0 ? true : false

  tags = {
    Name = var.public_instance_status == 0 ? "public-${count.index + 1}" : "private-${count.index + 1}"
  }

  root_block_device {
    volume_size = 8     # Size of the root volume in GB
    volume_type = "gp2" # Type of the root volume
  }

  ebs_block_device {
    device_name           = "/dev/sdh" # Device name on the instance
    volume_size           = 5          # Size of the additional volume in GB
    volume_type           = "gp2"      # Type of the additional volume
    delete_on_termination = true       # Whether to delete the volume when the instance is terminated
  }
}
