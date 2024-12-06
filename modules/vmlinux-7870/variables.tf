
variable "humber_id" {
  description = "Humber ID (Last 4 digits)"
  type        = string
}

variable "resource_group_name" {
  description = "Resource group name for the VMs"
  type        = string
}

variable "location" {
  description = "Location for resources"
  type        = string
}

# variable "vm_hostnames" {
#    description = "vms hostnames"
#   type        = string
# }


variable "vm_size" {
  description = "Size of the Linux VMs"
  type        = string
  default     = "Standard_DS1_v2"
}

variable "admin_username" {
  description = "Admin username for the VMs"
  type        = string
}

variable "public_key" {
  description = "Path to the SSH public key"
  type        = string
}

variable "private_key" {
  description = "Path to the SSH private key"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID where the VMs will be deployed"
  type        = string
}

variable "os_disk" {
  description = "The OS disk configuration for the VMs"
  type = object({
    storage_account_type = string
    disk_size_gb         = number
  })
  default = {
    storage_account_type = "Premium_LRS"
    disk_size_gb         = 30
  }
}
variable "vm_count" {
  description = "number of vms"
  type        = number
}

variable "storage_account_blob_endpoint" {
  description = "The primary blob endpoint of the storage account"
  type        = string
}

locals {
  tags = {
    Assignment     = "CCGC 5502 Automation Project"
    Name           = "innocent.audu"
    ExpirationDate = "2024-12-31"
    Environment    = "Project"
  }
}