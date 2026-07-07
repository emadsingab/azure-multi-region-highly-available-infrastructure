variable "project_name" {
  description = "Project name used in resource naming."
  type        = string
}

variable "environment" {
  description = "Environment name."
  type        = string
}

variable "traffic_manager_resource_group_name" {
  description = "Name of the Resource Group containing the Traffic Manager."
  type        = string
}

variable "traffic_routing_method" {
  description = "Traffic routing method used by Traffic Manager."
  type        = string
  default     = "Performance"
}

variable "regions" {
  description = "Map of regions config to deploy Load Balancers and endpoints."
  type = map(object({
    location            = string
    resource_group_name = string
  }))
}

variable "tags" {
  description = "Tags applied to Load Balancer and Traffic Manager resources."
  type        = map(string)
  default     = {}
}
