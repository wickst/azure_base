variable az_count {
  
}

resource "azurerm_resource_group" "example" {
  name     = "example-resource-group"
  location = "Australia East"
}

resource "azurerm_virtual_network" "example" {
  name                = "example-vnet"
  resource_group_name = "${azurerm_resource_group.example.name}"
  address_space       = ["10.200.0.0/16"]
  location            = "Australia East"
  dns_servers         = ["10.200.0.4", "10.200.0.5"]

  tags {
    environment = "Production"
  }
}

resource "azurerm_subnet" "public" {
  count = "${var.az_count}"
  name                 = "example-public-subnet-${count.index}"
  resource_group_name  = "${azurerm_resource_group.example.name}"
  virtual_network_name = "${azurerm_virtual_network.example.name}"
  address_prefix       = "10.200.${count.index}.0/24"
}

resource "azurerm_subnet" "app" {
  count = "${var.az_count}"
  name                 = "example-app-subnet-${count.index}"
  resource_group_name  = "${azurerm_resource_group.example.name}"
  virtual_network_name = "${azurerm_virtual_network.example.name}"
  address_prefix       = "10.200.${var.az_count + count.index}.0/24"
}

resource "azurerm_subnet" "data" {
  count = "${var.az_count}"
  name                 = "example-data-subnet-${count.index}"
  resource_group_name  = "${azurerm_resource_group.example.name}"
  virtual_network_name = "${azurerm_virtual_network.example.name}"
  address_prefix       = "10.200.${var.az_count * 2 + count.index}.0/24"
}

resource "azurerm_subnet" "mgmt" {
  count = "${var.az_count}"
  name                 = "example-mgmt-subnet-${count.index}"
  resource_group_name  = "${azurerm_resource_group.example.name}"
  virtual_network_name = "${azurerm_virtual_network.example.name}"
  address_prefix       = "10.200.${var.az_count * 3 + count.index}.0/24"
}