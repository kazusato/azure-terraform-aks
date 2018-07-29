provider "azurerm" {}

locals {
  rg_name = "aks_istio_rg"
}

variable "resource_location" {
  default = "japaneast"
}

variable "aks_node_count" {
  default = 4
}

variable "aks_sp_client_id" {}
variable "aks_sp_password" {}
