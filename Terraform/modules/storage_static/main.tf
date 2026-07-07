# create 2 azure storage accounts for static website
# and create a cdn profile for the 2 storage accounts
# and create a replicate objects between the 2 storage accounts
resource "azurerm_storage_account" "primary" {
  name                     = var.primary_storage_account_name
  resource_group_name      = var.primary_resource_group_name
  location                 = var.primary_location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  allow_nested_items_to_be_public = false

  blob_properties {
    versioning_enabled  = true
    change_feed_enabled = true
  }

  static_website {
    index_document     = "index.html"
    error_404_document = "404.html"
  }

  tags = var.tags
}

resource "azurerm_storage_account" "secondary" {
  name                     = var.secondary_storage_account_name
  resource_group_name      = var.secondary_resource_group_name
  location                 = var.secondary_location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  allow_nested_items_to_be_public = false

  blob_properties {
    versioning_enabled = true
  }

  static_website {
    index_document     = "index.html"
    error_404_document = "404.html"
  }

  tags = var.tags
}

resource "azurerm_storage_container" "primary_web" {
  name                  = "$web"
  storage_account_name  = azurerm_storage_account.primary.name
  container_access_type = "private"
}

resource "azurerm_storage_container" "secondary_web" {
  name                  = "$web"
  storage_account_name  = azurerm_storage_account.secondary.name
  container_access_type = "private"
}

resource "azurerm_cdn_frontdoor_profile" "main" {
  name                = "${var.project_name}-${var.environment}-fd-profile"
  resource_group_name = var.primary_resource_group_name
  sku_name            = "Standard_AzureFrontDoor"

  tags = var.tags
}

resource "azurerm_cdn_frontdoor_endpoint" "main" {
  name                     = "${var.project_name}-${var.environment}-fd-endpoint"
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.main.id

  tags = var.tags
}

resource "azurerm_cdn_frontdoor_origin_group" "main" {
  name                     = "${var.project_name}-${var.environment}-origin-group"
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.main.id

  load_balancing {
    sample_size                 = 4
    successful_samples_required = 3
  }

  health_probe {
    interval_in_seconds = 100
    path                = "/"
    protocol            = "Https"
    request_type        = "GET"
  }
}

resource "azurerm_cdn_frontdoor_origin" "primary" {
  name                          = "primary-storage"
  cdn_frontdoor_origin_group_id = azurerm_cdn_frontdoor_origin_group.main.id

  enabled                        = true
  host_name                      = azurerm_storage_account.primary.primary_web_host
  origin_host_header             = azurerm_storage_account.primary.primary_web_host
  http_port                      = 80
  https_port                     = 443
  priority                       = 1
  weight                         = 1000
  certificate_name_check_enabled = true
}

resource "azurerm_cdn_frontdoor_origin" "secondary" {
  name                          = "secondary-storage"
  cdn_frontdoor_origin_group_id = azurerm_cdn_frontdoor_origin_group.main.id

  enabled                        = true
  host_name                      = azurerm_storage_account.secondary.primary_web_host
  origin_host_header             = azurerm_storage_account.secondary.primary_web_host
  http_port                      = 80
  https_port                     = 443
  priority                       = 2
  weight                         = 1000
  certificate_name_check_enabled = true
}

resource "azurerm_cdn_frontdoor_route" "main" {
  name                          = "${var.project_name}-${var.environment}-route"
  cdn_frontdoor_endpoint_id     = azurerm_cdn_frontdoor_endpoint.main.id
  cdn_frontdoor_origin_group_id = azurerm_cdn_frontdoor_origin_group.main.id
  cdn_frontdoor_origin_ids = [
    azurerm_cdn_frontdoor_origin.primary.id,
    azurerm_cdn_frontdoor_origin.secondary.id
  ]

  supported_protocols    = ["Http", "Https"]
  patterns_to_match      = ["/*"]
  forwarding_protocol    = "HttpsOnly"
  https_redirect_enabled = true
  link_to_default_domain = true
}
