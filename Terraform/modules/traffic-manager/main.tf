# Create Traffic Manager Profile
# Traffic Manager is a DNS based load balancing service. It is used to distribute traffic across multiple regions.
resource "azurerm_traffic_manager_profile" "main" {
  name                   = var.name
  resource_group_name    = var.resource_group_name
  traffic_routing_method = var.traffic_routing_method

  dns_config {
    relative_name = var.name
    ttl           = var.dns_ttl
  }

  monitor_config {
    protocol = var.monitor_protocol
    port     = var.monitor_port
    path     = var.monitor_path
  }
}

# Create Traffic Manager External Endpoints
# External endpoints are endpoints that are not hosted in Azure.
# mean that is used to point  the Traffic Manager profile to an external endpoint.
# like an on premise data center.
resource "azurerm_traffic_manager_external_endpoint" "endpoints" {
  for_each = var.endpoints

  name       = each.key
  profile_id = azurerm_traffic_manager_profile.main.id
  target     = each.value.target

  endpoint_location = each.value.location
  weight            = each.value.weight
  priority          = each.value.priority
}
