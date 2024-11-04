variable "humber_id" {
  description = "Last 4 digits of Humber ID"
  type        = string
}

variable "location" {
  description = "Location for all resources"
  type        = string
}

variable "resource_group_name" {
  description = "Resource group where the data disks will be created"
  type        = string
}

variable "vm_ids" {
  description = "Map of VM IDs to attach the data disks"
  type        = map(string)
}
