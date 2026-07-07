# Create Public IP for Load Balancer
resource "azurerm_public_ip" "lb" {
  name                = var.public_ip_name
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
  tags                = var.tags
}

# Create Load Balancer
resource "azurerm_lb" "main" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "Standard"
  tags                = var.tags

  frontend_ip_configuration {
    name                 = var.frontend_ip_configuration_name
    public_ip_address_id = azurerm_public_ip.lb.id
  }
}

# Create Backend Address Pool
resource "azurerm_lb_backend_address_pool" "main" {
  name            = var.backend_pool_name
  loadbalancer_id = azurerm_lb.main.id
}

# Create Health Probe
resource "azurerm_lb_probe" "http" {
  name            = var.probe_name
  loadbalancer_id = azurerm_lb.main.id
  protocol        = "Http"
  port            = var.backend_port
  request_path    = var.probe_request_path
}

# Create Load Balancing rule
resource "azurerm_lb_rule" "http" {
  name                           = var.rule_name
  loadbalancer_id                = azurerm_lb.main.id
  protocol                       = "Tcp"
  frontend_port                  = var.frontend_port
  backend_port                   = var.backend_port
  frontend_ip_configuration_name = var.frontend_ip_configuration_name
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.main.id]
  probe_id                       = azurerm_lb_probe.http.id
}
