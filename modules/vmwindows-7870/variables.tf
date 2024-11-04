variable "humber_id" {
  description = "Last 4 digits of Humber ID"
  type        = string
}

variable "location" {
  description = "Location for all resources"
  type        = string
}

variable "resource_group_name" {
  description = "Resource group where the VM will be created"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID for the Windows VM"
  type        = string
}

variable "storage_account_blob_endpoint" {
  description = "Blob endpoint for boot diagnostics storage account"
  type        = string
}

variable "vm_size" {
  description = "Size of the Windows VM"
  type        = string
  default     = "Standard_DS1_v2"
}

variable "admin_username" {
  description = "Admin username for the Windows VM"
  type        = string
}

variable "admin_password" {
  description = "Admin password for the Windows VM"
  type        = string
  sensitive   = true
}

variable "vm_count" {
  description = "Number of Windows VMs"
  type        = number
}

resource "random_string" "suffix" {
  length  = 6     # Adjust the length as needed
  special = false # Set to true if you want special characters
  upper   = false
}


# variable "hostname" {
#   description = "vm hostname"
#   type = string
# }