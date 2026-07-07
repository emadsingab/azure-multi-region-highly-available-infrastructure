module "load_balancers" {
  for_each = var.regions

  source = "../load-balancer"

  name                           = "${var.project_name}-${each.key}-lb"
  public_ip_name                 = "${var.project_name}-${each.key}-lb-pip"
  location                       = each.value.location
  resource_group_name            = each.value.resource_group_name
  frontend_ip_configuration_name = "frontend"
  backend_pool_name              = "backend-pool"
  probe_name                     = "http-check"
  rule_name                      = "http-rule"
  
  frontend_port                  = 80
  backend_port                   = 80
  probe_request_path             = "/"
  tags                           = var.tags
}

module "traffic_manager" {
  source = "../traffic-manager"

  name                   = "${var.project_name}-${var.environment}-tm"
  resource_group_name    = var.traffic_manager_resource_group_name
  traffic_routing_method = var.traffic_routing_method

  endpoints = {
    for region_key, lb in module.load_balancers :
    region_key => {
      target   = lb.public_ip_fqdn
      location = var.regions[region_key].location
      weight   = 100
      priority = region_key == "westus" ? 1 : 2
    }
  }
}
