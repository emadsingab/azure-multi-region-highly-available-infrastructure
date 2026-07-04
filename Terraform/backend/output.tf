output "resource_group_name" {
  description = "Resource group that contains the Terraform state storage account."
  value       = azurerm_resource_group.tfstate.name
}

output "storage_account_name" {
  description = "Storage account used by the azurerm Terraform backend."
  value       = azurerm_storage_account.tfstate.name
}

output "container_name" {
  description = "Blob container used by the azurerm Terraform backend."
  value       = azurerm_storage_container.tfstate.name
}

output "backend_config_example" {
  description = "Backend block values to copy into an environment backend.tf file."
  value = {
    resource_group_name  = azurerm_resource_group.tfstate.name
    storage_account_name = azurerm_storage_account.tfstate.name
    container_name       = azurerm_storage_container.tfstate.name
    key                  = "dev.terraform.tfstate"
  }
}
