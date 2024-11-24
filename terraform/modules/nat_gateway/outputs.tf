output "nat_gateway_id" {
  description = "The IDs of the NAT gateways"
  value       = [for nat in aws_nat_gateway.nat_gateway : nat.id]
}
