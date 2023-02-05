resource "azurerm_public_ip" "ip-apache" {
  name                = "ip-apache"
  resource_group_name = azurerm_resource_group.exercicio-apache.name
  location            = azurerm_resource_group.exercicio-apache.location
  allocation_method   = "Static"

  tags = {
    environment = "Production"
  }
}

resource "azurerm_network_interface" "nic-apache" {
  name                = "nic-apache"
  location            = azurerm_resource_group.exercicio-apache.location
  resource_group_name = azurerm_resource_group.exercicio-apache.name

  ip_configuration {
    name                          = "nic-internal"
    subnet_id                     = azurerm_subnet.sub-apache.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.ip-apache.id
  }
}

resource "azurerm_virtual_machine" "vm-apache" {
  name                  = "vm-apache"
  location              = azurerm_resource_group.exercicio-apache.location
  resource_group_name   = azurerm_resource_group.exercicio-apache.name
  network_interface_ids = [azurerm_network_interface.nic-apache.id]
  vm_size               = "Standard_DS1_v2"

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }
  storage_os_disk {
    name              = "myosdisk1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = "hostname"
    admin_username = var.user
    admin_password = var.password
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
  tags = {
    environment = "staging"
  }
}