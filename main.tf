
/*
Naming Conventions
      RG = Resource Group
      VM = Virtual Machine
      Vnet = Virtual Network
      NSG = Network Security Group
      PIP = Public IP
      Stor = Storage Account
      NIC = Network Interface
      MD = Managed Disk



*/



provider "azurerm" {
version = "~> 1.25"
subscription_id="${var.subscription_id}"
client_id="${var.client_id}"
client_secret="${var.client_secret}"
tenant_id="${var.tenant_id}"
  }

variable "subscription_id"{}
variable "client_id"{}
variable "client_secret"{}
variable "tenant_id"{}


variable "environment" {
  description = "Define the environment to deploy to"
  default = "Production"
}

variable "subnet_name"{
  default = "default"
}
variable "vnet_name" {
  default = "SA-DEV-vnet"
}
variable "resource"{
  default= "SA-DEV"
}

variable "delete_os_disk_on_termination" {
  description = "(Optional) Flag to enable deletion of the OS disk VHD blob or managed disk when the VM is deleted, defaults to true."
  default     = true
}

variable "delete_data_disk_on_termination" {
  description = "(Optional) Flag to enable deletion of the OS disk VHD blob or managed disk when the VM is deleted, defaults to true."
  default     = true
}
variable "vm_name" {
  description = "Name of the virtual machine."
  default     = "CentosVM"
}
variable "hostname" {
  description = "Hostname to use for the virtual machine. Uses vmName if not provided."
  default     = "centos"
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
  default     = ""
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
  default = "sa-prod"
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


variable "data_disk" {
  description = "Create Virtual Machine with attached managed data disk. Default false"
  default     = "false"
}
variable "managed_disk_prefix" {
  description = "Specifies the name of the managed disk. Changing this forces a new resource to be created."
  default     = "md"
}

variable "managed_disk_storage_account_type" {
  description = "(Optional) The type of storage to use for the managed disk. Allowable values are Standard_LRS or Premium_LRS. Default = Standard_LRS."
  default     = "Standard_LRS"
}

variable "managed_disk_create_option" {
  description = "(Optional) The method to use when creating the managed disk. Values are Import, Empty, Copy, and FromImage. Default = Empty."
  default     = "Empty"
}

variable "managed_disk_size_gb" {
  description = "(Optional) Specifies the size of the os disk in gigabytes. Default 100 GB"
  default     = "32"
}

variable "boot_diagnostics_storage_uri" {
  default     = ""
  description = "Blob endpoint for the storage account to hold the virtual machine's diagnostic files. This must be the root of a storage account, and not a storage container."
}

variable "managed_disk_type" {
  description = "Specifies the type of managed disk to create. Value you must be either Standard_LRS or Premium_LRS. Cannot be used when vhd_uri is specified."
  default     = "Standard_LRS"
}

/*
variable "VM_PASSWORD" {
}

variable "admin_password" {
  
}

*/

