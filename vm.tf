
data "azurerm_resource_group" "res_group"{
    name  = "${var.resource}"
   // location  = "${var.azurerm_location}"
}

resource "azurerm_managed_disk" "dd" {
       count= "${var.nodecount}"
      name = "${var.prefix}-${var.vm_name}-${count.index}-DataDisk-${count.index}"
      location  = "${var.azurerm_location}"
      resource_group_name = "${data.azurerm_resource_group.res_group.name}"
      storage_account_type = "${var.managed_disk_storage_account_type}"
      create_option        = "${var.managed_disk_create_option}"
      disk_size_gb         = "${var.managed_disk_size_gb}"

}

resource "azurerm_virtual_machine" "vm" {
      count= "${var.nodecount}"
      name = "${var.prefix}-${var.vm_name}-${count.index}"
      location="${var.azurerm_location}"
      resource_group_name = "${data.azurerm_resource_group.res_group.name}"
      network_interface_ids = ["${element(azurerm_network_interface.nic.*.id,count.index)}"]
      vm_size = "${var.vm_size}"
      delete_os_disk_on_termination = "${var.delete_os_disk_on_termination}"
      //delete_data_disk_on_termination = "${var.delete_data_disk_on_termination}"

      storage_image_reference {
      publisher = "${var.vm_image_publisher}"
      offer = "${var.vm_image_offer}"
      sku = "${var.vm_image_sku}"
      version = "${var.vm_image_version}"
      }

      storage_os_disk {
      name = "${var.prefix}-osdisk${count.index}"
      caching = "ReadWrite"
      create_option = "FromImage"
      managed_disk_type = "${var.managed_disk_type}"
      disk_size_gb      = "${var.os_disk_size_gb}"
      }

# Adding additional disk  to multiple VMs

    storage_data_disk {
    name            = "${element(azurerm_managed_disk.dd.*.name, count.index)}"
    managed_disk_id = "${element(azurerm_managed_disk.dd.*.id, count.index)}"
    create_option   = "Attach"
    lun             = 0
    disk_size_gb    = "${element(azurerm_managed_disk.dd.*.disk_size_gb, count.index)}"
    }

      #define credentials # How can we create VM without specifying password in the code.
      os_profile {
      computer_name ="${var.prefix}-${var.vm_name}-${count.index}"
      admin_username = "${var.VM_ADMIN}"
     // admin_password = "${var.VM_PASSWORD}"
      }

       os_profile_linux_config {
    disable_password_authentication = true

    ssh_keys {
      path     = "/home/${var.VM_ADMIN}/.ssh/authorized_keys"
      key_data = "${file("/etc/ssh/ssh_host_rsa_key.pub")}"
    }
  }
   boot_diagnostics {
    enabled     = "${var.boot_diagnostics_storage_uri != "" ? true : false}"
    storage_uri = "${var.boot_diagnostics_storage_uri}"
  }

/*
// Adding Provisioner for Ansible
  provisioner "local-exec" {
 command = "sleep 120; ANSIBLE_HOST_KEY_CHECKING=False \ansible-playbook -u Nancy --private-key '${file("/etc/ssh/ssh_host_rsa_key")}' -i '${azurerm_public_ip.pip.*.ip_address},' Pingtest.yml"
 }
*/
}
/*
      os_profile_windows_config {
      provision_vm_agent = "true"
      enable_automatic_upgrades = "true"
      winrm {
      protocol = "http"
      certificate_url =""
      }
      }



#############   Azure Deployment template to domain join the VM ###################

#Extension: add server to domain
resource "azurerm_virtual_machine_extension" "ADD2AD" {
    name                 = "${Var.prefix}-VM"
    location             = "${var.azurerm_location}"
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
*/
