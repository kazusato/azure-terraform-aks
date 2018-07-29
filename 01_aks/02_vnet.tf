resource "azurerm_virtual_network" "aks_istio_vnet" {
  address_space = ["10.10.0.0/16"]
  location = "${var.resource_location}"
  name = "aks_istio_vnet"
  resource_group_name = "${azurerm_resource_group.azure_rg.name}"
}