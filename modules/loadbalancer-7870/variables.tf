variable "humber_id" {
  description = "Last 4 digits of Humber ID"
  type        = string
}

variable "resource_group_name" {
  description = "The resource group name where the Load Balancer will be created"
  type        = string
}

variable "location" {
  description = "Location for all resources"
  type        = string
}

variable "vm_nics" {
  description = "A map of the NIC IDs of the VMs"
  type        = map(string)
}
