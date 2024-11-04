variable "location" {
  default = "canadacentral"
}

variable "humber_id" {
  default = "7870"
}

variable "admin_username" {
  default = "n01657870"
}

variable "admin_password" {
  type      = string
  default   = "N01657870@Humber!"
  sensitive = true
}

variable "db_password" {
  type      = string
  sensitive = true
  default   = "ComplexP@ssw0rd123!"
}

module "common_services_7870" {
  source              = "./modules/common-7870"
  humber_id           = var.humber_id
  resource_group_name = module.resource_group.resource_group_name
  location            = var.location
  log_retention_days  = 30
}

locals {
  storage_account_blob_endpoint = module.common_services_7870.storage_account_blob_endpoint
}

module "datadisk_7870" {
  source              = "./modules/datadisk-7870"
  humber_id           = var.humber_id
  location            = var.location
  resource_group_name = module.resource_group.resource_group_name
  vm_ids = {
    0 = module.vmlinux_7870.vm1_id,
    1 = module.vmlinux_7870.vm2_id,
    2 = module.vmlinux_7870.vm3_id,
  }
}

module "loadbalancer_7870" {
  source              = "./modules/loadbalancer-7870"
  humber_id           = var.humber_id
  location            = var.location
  resource_group_name = module.resource_group.resource_group_name
  vm_nics = {
    vm1 = module.vmlinux_7870.vm1_nic_id,
    vm2 = module.vmlinux_7870.vm2_nic_id,
    vm3 = module.vmlinux_7870.vm3_nic_id
  }
}

module "database_7870" {
  source                        = "./modules/database-7870"
  humber_id                     = var.humber_id
  location                      = var.location
  resource_group_name           = module.resource_group.resource_group_name
  admin_username                = var.admin_username
  admin_password                = var.db_password
  storage_mb                    = 5120
  backup_retention_days         = 7
  auto_grow_enabled             = true
  public_network_access_enabled = true
}

module "network_7870" {
  source              = "./modules/network-7870"
  address_space       = ["10.0.0.0/16"]
  address_prefixes    = ["10.0.0.0/24"]
  humber_id           = var.humber_id
  location            = var.location
  resource_group_name = module.resource_group.resource_group_name
}

module "resource_group" {
  source              = "./modules/rgroup-7870"
  admin_username      = var.admin_username
  private_key         = file("~/.ssh/id_rsa")
  humber_id           = var.humber_id
  location            = var.location
  resource_group_name = "RG"
}

module "vmlinux_7870" {
  source                        = "./modules/vmlinux-7870"
  humber_id                     = var.humber_id
  location                      = var.location
  resource_group_name           = module.resource_group.resource_group_name
  admin_username                = var.admin_username
  public_key                    = file("~/.ssh/id_rsa.pub")
  subnet_id                     = module.network_7870.subnet_id
  private_key                   = file("~/.ssh/id_rsa")
  vm_count                      = 3
  storage_account_blob_endpoint = local.storage_account_blob_endpoint
}

module "vmwindows_7870" {
  source                        = "./modules/vmwindows-7870"
  humber_id                     = var.humber_id
  location                      = var.location
  resource_group_name           = module.resource_group.resource_group_name
  admin_username                = var.admin_username
  admin_password                = var.admin_password
  vm_count                      = 1
  subnet_id                     = module.network_7870.subnet_id
  storage_account_blob_endpoint = module.common_services_7870.storage_account_blob_endpoint
}
