resource "azurerm_subnet" "aks_istio_k8s_subnet" {
  address_prefix = "10.10.0.0/24"
  name = "aks_istio_k8s_subnet"
  resource_group_name = "${azurerm_resource_group.azure_rg.name}"
  virtual_network_name = "${azurerm_virtual_network.aks_istio_vnet.name}"
}