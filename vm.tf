


resource "azurerm_managed_disk" "test" {
name = "datadisk_existing"
location="${data.azurerm_resource_group.res_group.location}"
resource_group_name = "${data.azurerm_resource_group.res_group.name}"
storage_account_type = "Standard_LRS"
create_option = "Empty"
disk_size_gb = "1023"
}

resource "azurerm_virtual_machine" "test" {
name = "${var.prefix}-VM"
location="${data.azurerm_resource_group.res_group.location}"
resource_group_name = "${data.azurerm_resource_group.res_group.name}"
network_interface_ids = ["${azurerm_network_interface.NIC.id}"]
vm_size = "Standard_DS1_v2"
delete_os_disk_on_termination = "true"
delete_data_disks_on_termination = "true"

storage_image_reference {
publisher = "${var.vm_image_publisher}"
offer = "${var.vm_image_offer}"
sku = "${var.vm_image_sku}"
version = "${var.vm_image_version}"
}

storage_os_disk {
name = "datadisk_new_2018_01"
caching = "ReadWrite"
create_option = "FromImage"
managed_disk_type="Standard_LRS"
}

# Adding additional disk 1

storage_data_disk {
name = "datadisk_new"
managed_disk_type = "Standard_LRS"
create_option = "Empty"
lun = 0
disk_size_gb = "1023"
}

#Additional disk 2

storage_data_disk {
name = "${azurerm_managed_disk.test.name}"
managed_disk_id = "${azurerm_managed_disk.test.id}"
create_option = "Attach"
lun = 1
disk_size_gb = "${azurerm_managed_disk.test.disk_size_gb}"
}

#define credentials # How can we create VM without specifying password in the code.
os_profile {
computer_name = "SERVER2012"
admin_username = "${var.VM_ADMIN}"
admin_password = "${var.VM_PASSWORD}"
}

os_profile_windows_config {
provision_vm_agent = "true"
enable_automatic_upgrades = "true"
winrm {
protocol = "http"
certificate_url =""
}
}

}

#############   Azure Deployment template to domain join the VM ###################

#Extension: add server to domain
resource "azurerm_virtual_machine_extension" "ADD2AD" {
    name                 = "${Var.prefix}-VM"
    location             = "${data.azurerm_resource_group.res_group.location}"
    resource_group_name  = "${data.azurerm_resource_group.res_group.name}"
    virtual_machine_name = "${azurerm_virtual_machine.test.name}"
    publisher            = "Microsoft.Compute"
    type                 = "JsonADDomainExtension"
    type_handler_version = "1.3"
    # What the settings means: https://docs.microsoft.com/en-us/windows/desktop/api/lmjoin/nf-lmjoin-netjoindomain
 
    settings = <<SETTINGS
        {
            "Name": "ta2-dev.info",
            "OUPath": "OU=Servers,OU=TAdmin2,DC=ta2-dev,DC=info",
            "User": "ta2-dev\\",
            "Restart": "true",
            "Options": "3"
        }
SETTINGS
  protected_settings = <<PROTECTED_SETTINGS
    {
      "Password": "${var.admin_password}"
    }
  PROTECTED_SETTINGS
  depends_on = ["azurerm_virtual_machine.test"]
}

