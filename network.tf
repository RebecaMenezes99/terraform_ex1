resource "azurerm_virtual_network" "vnet-apache" {
  name                = "vnet-apache"
  location            = azurerm_resource_group.exercicio-apache.location
  resource_group_name = azurerm_resource_group.exercicio-apache.name
  address_space       = ["10.0.0.0/16"]

  tags = {
    faculdade = "Impacta"
    turma     = "fs05"
    matricula = "2202147"
    aluna     = "Rebeca Menezes Costa"
  }
}

resource "azurerm_subnet" "sub-apache" {
  name                 = "sub-apache"
  resource_group_name  = azurerm_resource_group.exercicio-apache.name
  virtual_network_name = azurerm_virtual_network.vnet-apache.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_network_security_group" "nsg-apache" {
  name                = "nsg-apache"
  location            = azurerm_resource_group.exercicio-apache.location
  resource_group_name = azurerm_resource_group.exercicio-apache.name

  security_rule {
    name                       = "Web"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  tags = {
    faculdade = "Impacta"
    turma     = "fs05"
    matricula = "2202147"
    aluna     = "Rebeca Menezes Costa"
  }
}