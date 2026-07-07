variable "name" {
  description = "Name of the Traffic Manager profile."
  type        = string
}

variable "resource_group_name" {
  description = "Name of the Resource Group that contains the Traffic Manager profile."
  type        = string
}

variable "traffic_routing_method" {
  description = "Traffic routing method used by Traffic Manager."
  type        = string
  default     = "Performance"
}

variable "dns_ttl" {
  description = "DNS TTL in seconds."
  type        = number
  default     = 30
}

variable "monitor_protocol" {
  description = "Protocol used by Traffic Manager health monitoring."
  type        = string
  default     = "HTTP"
}

variable "monitor_port" {
  description = "Port used by Traffic Manager health monitoring."
  type        = number
  default     = 80
}

variable "monitor_path" {
  description = "Path used by Traffic Manager health monitoring."
  type        = string
  default     = "/"
}

variable "endpoints" {
  description = "External endpoints routed by Traffic Manager."
  type = map(object({
    target   = string
    location = string
    weight   = optional(number, 100)
    priority = optional(number)
  }))
}
