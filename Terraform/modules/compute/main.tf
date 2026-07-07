# create an availability set to achieve high availability between VMs
resource "azurerm_availability_set" "main" {

  name                         = "${var.project_name}-${var.region_key}-avset"
  location                     = var.location
  resource_group_name          = var.resource_group_name
  platform_fault_domain_count  = 2
  platform_update_domain_count = 5
  managed                      = true

  tags = var.tags
}

resource "azurerm_network_interface" "main" {
  count = var.vm_count

  name                = "${var.project_name}-${var.region_key}-nic-${count.index + 1}"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
  }

  tags = var.tags
}

resource "azurerm_network_interface_backend_address_pool_association" "main" {
  count = var.vm_count

  network_interface_id    = azurerm_network_interface.main[count.index].id
  ip_configuration_name   = "internal"
  backend_address_pool_id = var.lb_backend_pool_id
}

resource "azurerm_linux_virtual_machine" "main" {
  count = var.vm_count

  name                = "${var.project_name}-${var.region_key}-vm-${count.index + 1}"
  location            = var.location
  resource_group_name = var.resource_group_name
  size                = var.vm_size
  admin_username      = var.admin_username

  disable_password_authentication = true

  network_interface_ids = [
    azurerm_network_interface.main[count.index].id
  ]

  availability_set_id = azurerm_availability_set.main.id

  admin_ssh_key {
    username   = var.admin_username
    public_key = var.admin_ssh_public_key
  }

  os_disk {
    name                 = "${var.project_name}-${var.region_key}-osdisk-${count.index + 1}"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

  custom_data = base64encode(templatefile("${path.module}/cloud-init.yaml", {
    region_name = var.region_key
    vm_number   = count.index + 1
  }))

  tags = var.tags
}
