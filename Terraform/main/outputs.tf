output "resource_group_names" {
  description = "Resource groups created for each region."

  value = {
    for region_key, rg in module.resource_group :
    region_key => rg.name
  }
}

output "vnet_ids" {
  description = "Virtual Network IDs for each region."

  value = {
    for region_key, network in module.network :
    region_key => network.id
  }
}

output "subnet_ids" {
  description = "Subnet IDs for each region."

  value = {
    for region_key, network in module.network :
    region_key => network.subnet_ids
  }
}

output "app_subnet_ids" {
  description = "Application subnet IDs for each region."

  value = {
    for region_key, network in module.network :
    region_key => network.subnet_ids[local.app_subnet_names[region_key]]
  }
}

output "bastion_subnet_id" {
  description = "Bastion subnet ID in the primary region."

  value = module.network["westus"].subnet_ids["AzureBastionSubnet"]
}

output "nat_gateway_ids" {
  description = "NAT Gateway IDs for each region."

  value = {
    for region_key, nat in module.nat_gateway :
    region_key => nat.id
  }
}

output "load_balancer_public_fqdns" {
  description = "Public FQDNs of the regional Load Balancers."

  value = module.lb_traffic_manager.lb_public_ip_fqdns
}

output "traffic_manager_fqdn" {
  description = "Global Traffic Manager DNS name."

  value = module.lb_traffic_manager.traffic_manager_fqdn
}

output "vm_private_ips" {
  description = "Private IP addresses of the VMs in each region."

  value = {
    for region_key, compute in module.compute :
    region_key => compute.private_ip_addresses
  }
}

output "bastion_public_ip" {
  description = "Public IP address of the Azure Bastion host."

  value = module.bastion.bastion_public_ip
}

output "frontdoor_hostname" {
  description = "Azure Front Door hostname for the static website."

  value = module.storage_static.frontdoor_hostname
}
