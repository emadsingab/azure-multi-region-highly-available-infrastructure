output "vm_ids" {
  value = azurerm_linux_virtual_machine.main[*].id
}

output "private_ip_addresses" {
  value = azurerm_network_interface.main[*].private_ip_address
}

output "availability_set_id" {
  value = azurerm_availability_set.main.id
}
