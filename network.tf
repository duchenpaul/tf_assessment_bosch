## Create a new Virtual Network, subnet and Network Security Group
resource "azurerm_virtual_network" "main" {
  count               = var.vnet_use_existing ? 0 : 1
  name                = "${var.resource_group_name}-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
}

resource "azurerm_subnet" "main" {
  count                = var.vnet_use_existing ? 0 : 1
  name                 = "subnet1"
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.main[0].name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_network_security_group" "main" {
  count               = var.vnet_use_existing ? 0 : 1
  name                = "${var.resource_group_name}-nsg"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  security_rule {
    name                       = "AllowInboundICMP"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Icmp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}



# Using existing Virtual Network, subnet and Network Security Group
data "azurerm_virtual_network" "existing_vnet" {
  name                = "LCY2-EU-North-CoreTools-VNET-Dev"
  resource_group_name = "LCY2-EU-North-CoreTools-VNET-Dev-RG"
}

data "azurerm_subnet" "existing_subnet" {
  name                 = "chend-dev-vm"
  virtual_network_name = data.azurerm_virtual_network.existing_vnet.name
  resource_group_name  = data.azurerm_virtual_network.existing_vnet.resource_group_name
}

data "azurerm_network_security_group" "existing_nsg" {
  name                = "ct-chend-test-nsg"
  resource_group_name = "chend-test"
}
