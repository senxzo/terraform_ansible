
variable "humber_id" {
  description = "Last 4 digits of Humber ID"
  type        = string
}


variable "resource_group_name" {
  description = "The name of the resource group where the services will be provisioned"
  type        = string
}


variable "location" {
  description = "Location for all resources"
  type        = string
}


variable "log_retention_days" {
  description = "Retention period for the Log Analytics Workspace"
  type        = number
  default     = 30
}

locals {
  tags = {
    Assignment     = "CCGC 5502 Automation Assignment"
    Name           = "innocent audu"
    ExpirationDate = "2024-12-31"
    Environment    = "Learning"
  }
}
  