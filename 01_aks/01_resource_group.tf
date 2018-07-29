resource "azurerm_resource_group" "azure_rg" {
  location = "${var.resource_location}"
  name = "${local.rg_name}"
}