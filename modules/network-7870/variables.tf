variable "humber_id" {
  description = "Last 4 digits of Humber ID"
  type        = string
}

variable "resource_group_name" {
  description = "Resource group name where the network will be created"
  type        = string
}

variable "location" {
  description = "Location for all resources"
  type        = string
}
variable "address_space" {
  description = "Address space"
  type        = list(string)
}
variable "address_prefixes" {
  description = "address prefix"
  type        = list(string)
}