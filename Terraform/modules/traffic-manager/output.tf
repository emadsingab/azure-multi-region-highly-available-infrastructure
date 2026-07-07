output "id" {
  description = "Traffic Manager profile ID."
  value       = azurerm_traffic_manager_profile.main.id
}

output "name" {
  description = "Traffic Manager profile name."
  value       = azurerm_traffic_manager_profile.main.name
}

output "fqdn" {
  description = "Traffic Manager DNS name."
  value       = azurerm_traffic_manager_profile.main.fqdn
}

output "endpoint_ids" {
  description = "Map of endpoint names to endpoint IDs."
  value = {
    for endpoint_name, endpoint in azurerm_traffic_manager_external_endpoint.endpoints :
    endpoint_name => endpoint.id
  }
}
