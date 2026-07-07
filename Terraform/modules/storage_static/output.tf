output "primary_storage_web_endpoint" {
  value = azurerm_storage_account.primary.primary_web_endpoint
}

output "secondary_storage_web_endpoint" {
  value = azurerm_storage_account.secondary.primary_web_endpoint
}

output "frontdoor_hostname" {
  value = azurerm_cdn_frontdoor_endpoint.main.host_name
}
