


data azurerm_virtual_network "Vnet" {
    name = "${var.vnet_name}"
    //address_space = ["10.5.0.0/16"]
    //location = "${var.azurerm_location}"
    resource_group_name = "${data.azurerm_resource_group.res_group.name}"
}
output "virtual_network_id" {
  value = "${data.azurerm_virtual_network.Vnet.id}"
}

data azurerm_subnet "subnet" {
    name = "${var.subnet_name}"
    //address_prefix = "10.5.40.0/22"
    virtual_network_name = "${data.azurerm_virtual_network.Vnet.name}"
    resource_group_name = "${data.azurerm_resource_group.res_group.name}"
}
output "subnet_id" {
  value = "${data.azurerm_subnet.subnet.id}"
}

resource "azurerm_network_interface" "nic" {
  count= "${var.nodecount}"
  name= "${var.prefix}-${var.vm_name}-${count.index}-nic"
  location = "${var.azurerm_location}"
  resource_group_name = "${data.azurerm_resource_group.res_group.name}"

  ip_configuration {
      name = "${var.prefix}-nicConfig"
      subnet_id= "${data.azurerm_subnet.subnet.id}"
      private_ip_address_allocation="Dynamic"
      public_ip_address_id          = "${element(azurerm_public_ip.pip.*.id,count.index)}"
      
  }
}

resource "azurerm_public_ip" "pip" {
  count= "${var.nodecount}"
  name= "${var.prefix}-${var.vm_name}-${count.index}-nic"
  location = "${var.azurerm_location}"
  resource_group_name = "${data.azurerm_resource_group.res_group.name}"
  allocation_method = "Dynamic"

  tags {
    environment = "${var.environment}"
  }
}
/*
data "azurerm_network_security_group" "netsecgrp" {
  name                = "AADDS-ta2-dev.info-NSG"
  resource_group_name = "${data.azurerm_resource_group.res_group.name}"
}

output "location" {
  value = "${data.azurerm_network_security_group.netsecgrp.location}"
}
*/



