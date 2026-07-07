locals {
  name_prefix = "${var.project_name}-${var.environment}"

  regions = {
    westus = {
      location       = "West US"
      address_space  = ["10.10.0.0/16"]
      app_subnet     = ["10.10.1.0/24"]
      bastion_subnet = ["10.10.100.0/26"]
    }

    eastus = {
      location       = "East US"
      address_space  = ["10.20.0.0/16"]
      app_subnet     = ["10.20.1.0/24"]
      bastion_subnet = ["10.20.100.0/26"]
    }
  }

  app_subnet_names = {
    for region_key, region_config in local.regions :
    region_key => "${local.name_prefix}-${region_key}-app-subnet"
  }

  tags = {
    project     = var.project_name
    environment = var.environment
    managed_by  = "terraform"
  }
}

module "resource_group" {
  for_each = local.regions

  source = "../modules/resource-group"

  name     = "${local.name_prefix}-${each.key}-rg"
  location = each.value.location
  tags     = local.tags
}

module "network" {
  for_each = local.regions

  source = "../modules/network"

  name                = "${local.name_prefix}-${each.key}-vnet"
  location            = each.value.location
  resource_group_name = module.resource_group[each.key].name
  address_space       = each.value.address_space

  subnets = {
    "${local.app_subnet_names[each.key]}" = {
      address_prefixes = each.value.app_subnet
    }

    "AzureBastionSubnet" = {
      address_prefixes = each.value.bastion_subnet
    }
  }

  tags = local.tags
}

module "nat_gateway" {
  for_each = local.regions

  source = "../modules/nat-gateway"

  name                = "${local.name_prefix}-${each.key}-nat-gw"
  public_ip_name      = "${local.name_prefix}-${each.key}-nat-pip"
  location            = each.value.location
  resource_group_name = module.resource_group[each.key].name
  subnet_id           = module.network[each.key].subnet_ids[local.app_subnet_names[each.key]]

  tags = local.tags
}

module "lb_traffic_manager" {
  source = "../modules/lb_traffic_manager"

  project_name = var.project_name
  environment  = var.environment

  traffic_manager_resource_group_name = module.resource_group["westus"].name
  traffic_routing_method              = "Performance"

  regions = {
    for region_key, region_config in local.regions :
    region_key => {
      location            = region_config.location
      resource_group_name = module.resource_group[region_key].name
    }
  }

  tags = local.tags
}

module "compute" {
  for_each = local.regions

  source = "../modules/compute"

  project_name        = var.project_name
  region_key          = each.key
  location            = each.value.location
  resource_group_name = module.resource_group[each.key].name

  subnet_id          = module.network[each.key].subnet_ids[local.app_subnet_names[each.key]]
  lb_backend_pool_id = module.lb_traffic_manager.lb_backend_pool_ids[each.key]

  vm_count             = var.vm_count_per_region
  vm_size              = var.vm_size
  admin_username       = var.admin_username
  admin_ssh_public_key = var.admin_ssh_public_key

  tags = local.tags
}

module "bastion" {
  source = "../modules/Bastion"

  project_name        = var.project_name
  region_key          = "westus"
  location            = local.regions["westus"].location
  resource_group_name = module.resource_group["westus"].name
  bastion_subnet_id   = module.network["westus"].subnet_ids["AzureBastionSubnet"]

  tags = local.tags
}

module "vnet_peering" {
  source = "../modules/vnet-peering"

  source_peering_name = "westus-to-eastus"
  target_peering_name = "eastus-to-westus"

  source_resource_group_name = module.resource_group["westus"].name
  target_resource_group_name = module.resource_group["eastus"].name

  source_virtual_network_name = module.network["westus"].name
  target_virtual_network_name = module.network["eastus"].name

  source_virtual_network_id = module.network["westus"].id
  target_virtual_network_id = module.network["eastus"].id

  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
  allow_gateway_transit        = false
  use_remote_gateways          = false
}

module "storage_static" {
  source = "../modules/storage_static"

  project_name = var.project_name
  environment  = var.environment

  primary_storage_account_name   = "mrhadevweststorage01"
  secondary_storage_account_name = "mrhadeveaststorage01"

  primary_resource_group_name   = module.resource_group["westus"].name
  secondary_resource_group_name = module.resource_group["eastus"].name

  primary_location   = local.regions["westus"].location
  secondary_location = local.regions["eastus"].location

  tags = local.tags
}
