variable "name" {
  description = "Name of the Azure Load Balancer."
  type        = string
}

variable "public_ip_name" {
  description = "Name of the Public IP used by the Load Balancer frontend."
  type        = string
}

variable "location" {
  description = "Azure region where the Load Balancer will be deployed."
  type        = string
}

variable "resource_group_name" {
  description = "Name of the Resource Group that contains the Load Balancer."
  type        = string
}

variable "frontend_ip_configuration_name" {
  description = "Name of the frontend IP configuration."
  type        = string
  default     = "frontend"
}

variable "backend_pool_name" {
  description = "Name of the backend address pool."
  type        = string
  default     = "backend-pool"
}

variable "probe_name" {
  description = "Name of the health probe."
  type        = string
  default     = "http-check"
}

variable "rule_name" {
  description = "Name of the load balancing rule."
  type        = string
  default     = "http-rule"
}

variable "frontend_port" {
  description = "Frontend port exposed by the Load Balancer."
  type        = number
  default     = 80
}

variable "backend_port" {
  description = "Backend port used by the virtual machines."
  type        = number
  default     = 80
}

variable "probe_request_path" {
  description = "HTTP path used by the health probe."
  type        = string
  default     = "/"
}

variable "tags" {
  description = "Tags applied to Load Balancer resources."
  type        = map(string)
  default     = {}
}
