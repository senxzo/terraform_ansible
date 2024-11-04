variable "humber_id" {
  description = "Last 4 digits of Humber ID"
  type        = string
}

variable "location" {
  description = "Location for all resources"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "admin_username" {
  description = "Administrator username for the PostgreSQL server"
  type        = string
}

variable "admin_password" {
  description = "Administrator password for the PostgreSQL server"
  type        = string
  sensitive   = true
}

variable "storage_mb" {
  description = "Storage size in MB"
  type        = number
}

variable "backup_retention_days" {
  description = "Number of days for backup retention"
  type        = number
}


variable "auto_grow_enabled" {
  description = "Enable storage auto-grow"
  type        = bool
}

variable "public_network_access_enabled" {
  description = "Enable public network access to the PostgreSQL server"
  type        = bool
}
