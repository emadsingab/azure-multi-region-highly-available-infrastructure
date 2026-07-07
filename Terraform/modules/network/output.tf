output "name" {
  description = "Virtual Network name."
  value       = azurerm_virtual_network.main.name
}

output "id" {
  description = "Virtual Network Azure resource ID."
  value       = azurerm_virtual_network.main.id
}

output "location" {
  description = "Virtual Network location."
  value       = azurerm_virtual_network.main.location
}

output "address_space" {
  description = "Virtual Network address space."
  value       = azurerm_virtual_network.main.address_space
}

output "subnet_ids" {
  description = "Map of subnet names to subnet IDs."
  value = {
    for subnet_name, subnet in azurerm_subnet.subnets :
    subnet_name => subnet.id
  }
}

output "subnet_names" {
  description = "List of subnet names created inside the Virtual Network."
  value       = keys(azurerm_subnet.subnets)
}
