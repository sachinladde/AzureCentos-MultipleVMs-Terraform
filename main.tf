
terraform 
{
provider "azurerm" {
subscription_id="${var.AZURE_SUBSCRIPTION_ID}"
client_id="${var.AZURE_CLIENT_ID}"
client_secret="${var.AZURE_CLIENT_SECRET}"
tenant_id="${var.AZURE_TENANT_ID}"
}
}

variable "vm_image_publisher" {
// Get-AzureRmVMImagePublisher -Location 'uksouth' | Select PublisherName
description = "vm image vendor"
default = "MicrosoftWindowsServer"
}
variable "vm_image_offer" {
//Get-AzureRMVMImageOffer -Location 'uksouth' -Publisher 'MicrosoftWindowsServer' | Select Offer
description = "vm image vendor's VM offering"
default = "WindowsServer"
}
variable "prefix" {
  default = "Tdev-BTS-Test"
}
variable "vm_image_sku" {
default = "2012-Datacenter-R2"
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


variable "vm_size" {
//https://github.com/terraform-providers/terraform-provider-azurerm/issues/1314 
#Get-AzureRmVMSize -Location 'uksouth' | select name, NumberOfCores, MemoryInMB, ResourceDiskSizeInMB | ft
//https://azure.microsoft.com/en-us/documentation/articles/cloud-services-sizes-specs/
//https://azure.microsoft.com/en-gb/documentation/articles/virtual-machines-windows-sizes/
//https://azure.microsoft.com/en-us/pricing/details/virtual-machines/windows/
description = "VM instance size"
default = "Standard_A4_v2"
}






