resource "azurerm_kubernetes_cluster" "aks_istio_cluster" {
  "agent_pool_profile" {
    name = "default"
    count = "${var.aks_node_count}"
    vm_size = "Standard_B2s"
    os_type = "Linux"
    os_disk_size_gb = 30
    vnet_subnet_id = "${azurerm_subnet.aks_istio_k8s_subnet.id}"
  }
  dns_prefix = "aic"
  "linux_profile" {
    admin_username = "aicadmin"
    "ssh_key" {
      key_data = "${file("nogit/id_rsa.pub")}"
    }
  }
  kubernetes_version = "1.10.5"
  location = "${var.resource_location}"
  name = "aks_istio_cluster"
  resource_group_name = "${azurerm_resource_group.azure_rg.name}"
  "service_principal" {
    client_id = "${var.aks_sp_client_id}"
    client_secret = "${var.aks_sp_password}"
  }
}