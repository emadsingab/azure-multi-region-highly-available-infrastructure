variable "project_name" {
  type        = string
  description = "Project name used in resource naming."
}

variable "region_key" {
  type        = string
  description = "Short region key like westus or eastus."
}

variable "location" {
  type        = string
  description = "Azure region location."
}

variable "resource_group_name" {
  type        = string
  description = "Resource group name."
}

variable "subnet_id" {
  type        = string
  description = "Subnet ID where VMs will be deployed."
}

variable "lb_backend_pool_id" {
  type        = string
  description = "Load Balancer backend pool ID."
}

variable "vm_count" {
  type        = number
  description = "Number of VMs to create."
  default     = 2

  validation {
    condition     = var.vm_count >= 2
    error_message = "For high availability, vm_count should be at least 2."
  }
}

variable "vm_size" {
  type        = string
  description = "Azure VM size."
  default     = "Standard_B1s"
}

variable "admin_username" {
  type        = string
  description = "Admin username for Linux VMs."
  default     = "azureuser"
}

variable "admin_ssh_public_key" {
  type        = string
  description = "SSH public key used to access VMs through Bastion."
  sensitive   = true
}

variable "tags" {
  type        = map(string)
  description = "Tags applied to resources."
  default     = {}
}
