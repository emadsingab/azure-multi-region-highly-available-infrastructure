variable "name" {
  description = "Name of the Azure Virtual Network."
  type        = string
}

variable "location" {
  description = "Azure region where the Virtual Network will be deployed."
  type        = string
}

variable "resource_group_name" {
  description = "Name of the Resource Group that contains the Virtual Network."
  type        = string
}

variable "address_space" {
  description = "Address space CIDR blocks assigned to the Virtual Network."
  type        = list(string)
}

variable "subnets" {
  description = "Map of subnet names to subnet address prefixes."
  type = map(object({
    address_prefixes = list(string)
  }))
}

variable "tags" {
  description = "Tags applied to the Virtual Network."
  type        = map(string)
  default     = {}
}
