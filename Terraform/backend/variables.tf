variable "resource_group_name" {
  description = "Resource group that will contain the Terraform remote state storage resources."
  type        = string
  default     = "rg-tfstate"
}

variable "location" {
  description = "Azure region for the Terraform state resource group and storage account."
  type        = string
  default     = "eastus"
}

variable "storage_account_name" {
  description = "Globally unique storage account name used for Terraform state."
  type        = string

  validation {
    condition     = can(regex("^[a-z0-9]{3,24}$", var.storage_account_name))
    error_message = "Storage account name must be 3-24 characters, lowercase letters and numbers only."
  }
}

variable "container_name" {
  description = "Blob container name that will store Terraform state files."
  type        = string
  default     = "tfstate"
}

variable "tags" {
  description = "Common tags for backend resources."
  type        = map(string)
  default = {
    project     = "azure-ha-terraform"
    managed_by  = "terraform"
    environment = "bootstrap"
  }
}
