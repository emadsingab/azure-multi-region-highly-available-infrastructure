resource "azurerm_public_ip" "main" {
  name                = "${var.project_name}-${var.region_key}-bastion-pip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"

  tags = var.tags
}

resource "azurerm_bastion_host" "main" {
  name                = "${var.project_name}-${var.region_key}-bastion"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                 = "configuration"
    subnet_id            = var.bastion_subnet_id
    public_ip_address_id = azurerm_public_ip.main.id
  }

  tags = var.tags
}
