


data azurerm_virtual_network "Vnet" {
    name = "TAdmin2-Network1"
    //address_space = ["10.5.0.0/16"]
    //location = "${var.azurerm_location}"
    resource_group_name = "${data.azurerm_resource_group.res_group.name}"
}
output "virtual_network_id" {
  value = "${data.azurerm_virtual_network.Vnet.id}"
}

data azurerm_subnet "subnet" {
    name = "TDEv-Development"
    //address_prefix = "10.5.40.0/22"
    virtual_network_name = "${data.azurerm_virtual_network.Vnet.name}"
    resource_group_name = "${data.azurerm_resource_group.res_group.name}"
}
output "subnet_id" {
  value = "${data.azurerm_subnet.subnet.id}"
}

resource "azurerm_network_interface" "nic" {
  name= "${var.prefix}-NIC"
  location = "${var.azurerm_location}"
  resource_group_name = "${data.azurerm_resource_group.res_group.name}"

  ip_configuration {
      name = "${var.prefix}-nicConfig"
      subnet_id= "${data.azurerm_subnet.subnet.id}"
      private_ip_address_allocation="Dynamic"
      
  }
}

#/.. get public IP (need to check with Tressa)
#data "azurerm_public_ip" "pip" {
#name = "${azurerm_public_ip.datasourceip.name}"
#resource_group_name = "${data.azurerm_resource_group.res_group.name}"
#depends_on = ["azurerm_virtual_machine.test"]
#}

#output "ip_address" {
#value = "${data.azurerm_public_ip.pip.ip_address}"
#}

data "azurerm_network_security_group" "netsecgrp" {
  name                = "AADDS-ta2-dev.info-NSG"
  resource_group_name = "${data.azurerm_resource_group.res_group.name}"
}

output "location" {
  value = "${data.azurerm_network_security_group.netsecgrp.location}"
}