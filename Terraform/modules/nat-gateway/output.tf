output "id" {
  description = "NAT Gateway Azure resource ID."
  value       = azurerm_nat_gateway.main.id
}

output "name" {
  description = "NAT Gateway name."
  value       = azurerm_nat_gateway.main.name
}

output "public_ip_id" {
  description = "Public IP resource ID used by the NAT Gateway."
  value       = azurerm_public_ip.nat.id
}

output "public_ip_address" {
  description = "Public IP address used for outbound traffic."
  value       = azurerm_public_ip.nat.ip_address
}

output "subnet_association_id" {
  description = "Subnet NAT Gateway association ID."
  value       = azurerm_subnet_nat_gateway_association.main.id
}
