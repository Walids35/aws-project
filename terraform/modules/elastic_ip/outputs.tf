# elastic_ip/outputs.tf

output "elastic_ip_allocation_id" {
  description = "The allocation ID of the Elastic IP"
  value       = aws_eip.elastic_ip.id
}
