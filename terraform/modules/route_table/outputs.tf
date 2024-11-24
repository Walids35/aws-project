output "route_table_id" {
  value = aws_route_table.public_route_table.id
}

# outputs.tf

output "private_route_table_id" {
  description = "ID of the private route table"
  value       = aws_route_table.private_route_table.id
}
