provider "azurerm" {

}

module "network" {
    source = "./network"
    az_count = "${var.az_count}"
}