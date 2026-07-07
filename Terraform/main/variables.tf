variable "subscription_id" {
  type        = string
  description = "Azure subscription ID."
}

variable "project_name" {
  type        = string
  description = "Project name used in resource naming."
  default     = "multi-region-ha"
}

variable "environment" {
  type        = string
  description = "Environment name."
  default     = "dev"

  validation {
    condition     = contains(["dev", "test", "prod"], var.environment)
    error_message = "Environment must be one of: dev, test, prod."
  }
}

variable "admin_username" {
  type        = string
  description = "Linux VM admin username."
  default     = "azureuser"
}

variable "admin_ssh_public_key" {
  type        = string
  description = "SSH public key for VM access through Bastion."
  sensitive   = true
}

variable "vm_size" {
  type        = string
  description = "Azure VM size."
  default     = "Standard_B1s"
}

variable "vm_count_per_region" {
  type        = number
  description = "Number of VMs per region."
  default     = 2

  validation {
    condition     = var.vm_count_per_region >= 2
    error_message = "For HA, each region should have at least 2 VMs."
  }
}
