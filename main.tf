
/*
Naming Conventions
      RG = Resource Group
      VM = Virtual Machine
      Vnet = Virtual Network
      NSG = Network Security Group
      PIP = Public IP
      Stor = Storage Account
      NIC = Network Interface



*/


terraform 
{
provider "azurerm" {
subscription_id="${var.AZURE_SUBSCRIPTION_ID}"
client_id="${var.AZURE_CLIENT_ID}"
client_secret="${var.AZURE_CLIENT_SECRET}"
tenant_id="${var.AZURE_TENANT_ID}"
  }
}



variable "vm_size" {
  description = "Azure VM Size to use. See: https://docs.microsoft.com/en-us/azure/cloud-services/cloud-services-sizes-specs"
  default     = "Standard_B2s"
}

variable "os_disk_size_gb" {
  description = "(Optional) Specifies the size of the os disk in gigabytes. Default 32 GB"
  default     = "32"
}

variable "admin_public_key" {
  description = "Optionally supply the admin public key. If provided, will override variable: sshKey"
  default     = ""
}

variable "ssh_key_path" {
  description = "Path to the public key to be used for ssh access to the VM. Default is ~/.ssh/id_rsa.pub. If specifying a path to a certification on a Windows machine to provision a linux vm use the / in the path versus backslash. e.g. c:/home/id_rsa.pub"
  default     = "~/.ssh/id_rsa.pub"
}

variable "azurerm_location"{
  default = "southindia"
}

variable "nodecount"{
  default = 2
}
variable "vm_image_publisher" {
// Get-AzureRmVMImagePublisher -Location 'uksouth' | Select PublisherName
description = "vm image vendor"
default = "openLogic"
}
variable "vm_image_offer" {
//Get-AzureRMVMImageOffer -Location 'uksouth' -Publisher 'MicrosoftWindowsServer' | Select Offer
description = "vm image vendor's VM offering"
default = "CentOS"
}
variable "prefix" {
  default = "SA-prod"
}
variable "vm_image_sku" {
default = "7.3"
}

variable "vm_image_version" {
description = "vm image version"
default = "latest"
}
variable "VM_ADMIN" {
//Disallowed values: "administrator", "admin", "user", "user1", "test", "user2", "test1", "user3", "admin1", "1", "123", "a", "actuser", "adm", "admin2", "aspnet", "backup", "console", "david", "guest", "john", "owner", "root", "server", "sql", "support", "support_388945a0", "sys", "test2", "test3", "user4", "user5".
}

variable "VM_PASSWORD" {
}

variable "admin_password" {
  
}
variable "data_disk" {
  description = "Create Virtual Machine with attached managed data disk. Default false"
  default     = "false"
}
variable "managed_disk_type" {
  description = "Specifies the type of managed disk to create. Value you must be either Standard_LRS or Premium_LRS. Cannot be used when vhd_uri is specified."
  default     = "Standard_LRS"
}

variable "vm_size" {
//https://github.com/terraform-providers/terraform-provider-azurerm/issues/1314 
#Get-AzureRmVMSize -Location 'uksouth' | select name, NumberOfCores, MemoryInMB, ResourceDiskSizeInMB | ft
//https://azure.microsoft.com/en-us/documentation/articles/cloud-services-sizes-specs/
//https://azure.microsoft.com/en-gb/documentation/articles/virtual-machines-windows-sizes/
//https://azure.microsoft.com/en-us/pricing/details/virtual-machines/windows/
description = "VM instance size"
default = "Standard_A4_v2"
}






