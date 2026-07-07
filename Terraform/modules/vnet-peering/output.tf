output "source_to_target_id" {
  description = "ID of the peering from source VNet to target VNet."
  value       = azurerm_virtual_network_peering.source_to_target.id
}

output "target_to_source_id" {
  description = "ID of the peering from target VNet to source VNet."
  value       = azurerm_virtual_network_peering.target_to_source.id
}

output "source_to_target_name" {
  description = "Name of the peering from source VNet to target VNet."
  value       = azurerm_virtual_network_peering.source_to_target.name
}

output "target_to_source_name" {
  description = "Name of the peering from target VNet to source VNet."
  value       = azurerm_virtual_network_peering.target_to_source.name
}
