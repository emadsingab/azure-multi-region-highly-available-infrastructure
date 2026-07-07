variable "source_peering_name" {
  description = "Name of the peering from the source VNet to the target VNet."
  type        = string
}

variable "target_peering_name" {
  description = "Name of the peering from the target VNet back to the source VNet."
  type        = string
}

variable "source_resource_group_name" {
  description = "Resource Group name of the source Virtual Network."
  type        = string
}

variable "target_resource_group_name" {
  description = "Resource Group name of the target Virtual Network."
  type        = string
}

variable "source_virtual_network_name" {
  description = "Name of the source Virtual Network."
  type        = string
}

variable "target_virtual_network_name" {
  description = "Name of the target Virtual Network."
  type        = string
}

variable "source_virtual_network_id" {
  description = "Azure resource ID of the source Virtual Network."
  type        = string
}

variable "target_virtual_network_id" {
  description = "Azure resource ID of the target Virtual Network."
  type        = string
}

variable "allow_virtual_network_access" {
  description = "Allow resources in the peered VNets to communicate with each other."
  type        = bool
  default     = true
}

variable "allow_forwarded_traffic" {
  description = "Allow forwarded traffic from the remote VNet."
  type        = bool
  default     = true
}

variable "allow_gateway_transit" {
  description = "Allow gateway transit from this VNet to the peered VNet."
  type        = bool
  default     = false
}

variable "use_remote_gateways" {
  description = "Use the remote VNet gateway for this VNet."
  type        = bool
  default     = false
}
