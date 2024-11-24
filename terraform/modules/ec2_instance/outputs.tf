output "ec2_instance_ids" {
  value = aws_instance.ec2_instance[*].id
}

output "ec2_instance_public_ips" {
  value = aws_instance.ec2_instance[*].public_ip
}

output "ec2_instance_private_ips" {
  value = aws_instance.ec2_instance[*].private_ip
}

output "ec2_instance_tags" {
  value = aws_instance.ec2_instance[*].tags
}
