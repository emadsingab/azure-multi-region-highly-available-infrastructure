resource "azurerm_virtual_network_peering" "source_to_target" {
  name                         = var.source_peering_name
  resource_group_name          = var.source_resource_group_name
  virtual_network_name         = var.source_virtual_network_name
  remote_virtual_network_id    = var.target_virtual_network_id
  allow_virtual_network_access = var.allow_virtual_network_access
  allow_forwarded_traffic      = var.allow_forwarded_traffic
  allow_gateway_transit        = var.allow_gateway_transit
  use_remote_gateways          = var.use_remote_gateways
}

resource "azurerm_virtual_network_peering" "target_to_source" {
  name                         = var.target_peering_name
  resource_group_name          = var.target_resource_group_name
  virtual_network_name         = var.target_virtual_network_name
  remote_virtual_network_id    = var.source_virtual_network_id
  allow_virtual_network_access = var.allow_virtual_network_access
  allow_forwarded_traffic      = var.allow_forwarded_traffic
  allow_gateway_transit        = var.allow_gateway_transit
  use_remote_gateways          = var.use_remote_gateways
}
