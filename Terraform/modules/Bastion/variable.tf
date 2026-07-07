variable "project_name" {
  type        = string
  description = "Project name used in resource naming."
}

variable "region_key" {
  type        = string
  description = "Short region key like westus."
}

variable "location" {
  type        = string
  description = "Azure location."
}

variable "resource_group_name" {
  type        = string
  description = "Resource group name."
}

variable "bastion_subnet_id" {
  type        = string
  description = "ID of AzureBastionSubnet."
}

variable "tags" {
  type        = map(string)
  description = "Tags applied to resources."
  default     = {}
}
