variable "name" {
  description = "Name of the Azure NAT Gateway."
  type        = string
}

variable "public_ip_name" {
  description = "Name of the Public IP used by the NAT Gateway."
  type        = string
}

variable "location" {
  description = "Azure region where the NAT Gateway will be deployed."
  type        = string
}

variable "resource_group_name" {
  description = "Name of the Resource Group that contains the NAT Gateway."
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID that will be associated with the NAT Gateway."
  type        = string
}

variable "tags" {
  description = "Tags applied to NAT Gateway resources."
  type        = map(string)
  default     = {}
}
