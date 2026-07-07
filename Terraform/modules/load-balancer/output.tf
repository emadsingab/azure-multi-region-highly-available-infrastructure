output "id" {
  description = "Load Balancer Azure resource ID."
  value       = azurerm_lb.main.id
}

output "name" {
  description = "Load Balancer name."
  value       = azurerm_lb.main.name
}

output "public_ip_id" {
  description = "Public IP resource ID."
  value       = azurerm_public_ip.lb.id
}

output "public_ip_address" {
  description = "Public IP address assigned to the Load Balancer."
  value       = azurerm_public_ip.lb.ip_address
}

output "backend_pool_id" {
  description = "Backend pool ID used by VM NIC associations."
  value       = azurerm_lb_backend_address_pool.main.id
}
