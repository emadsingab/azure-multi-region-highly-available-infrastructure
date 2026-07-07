variable "project_name" {
  type = string
}

variable "environment" {
  type = string
}

variable "primary_storage_account_name" {
  type        = string
  description = "Globally unique primary storage account name."
}

variable "secondary_storage_account_name" {
  type        = string
  description = "Globally unique secondary storage account name."
}

variable "primary_resource_group_name" {
  type = string
}

variable "secondary_resource_group_name" {
  type = string
}

variable "primary_location" {
  type = string
}

variable "secondary_location" {
  type = string
}

variable "tags" {
  type    = map(string)
  default = {}
}
