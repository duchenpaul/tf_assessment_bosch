variable "private_key_path" {
  description = "Private key path used to execute commands remotely"
  type        = string
}

variable "tenant_id" {
  description = "The tenant id of the Azure account"
  type        = string
}

variable "owner_details" {
  description = "The map of owners of Azure resources"
  type        = map(any)
}

## Network
variable "vnet_use_existing" {
  description = "Flag to indicate whether to use an existing virtual network, otherwise a new one will be created"
  type        = bool
  default     = true
}

## VM
variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "location" {
  description = "The Azure region to deploy resources"
  type        = string
  default     = "East US"
}

variable "vm_count" {
  description = "Number of VMs to create"
  type        = number
  default     = 2
}

variable "vm_size" {
  description = "VM size"
  type        = string
  default     = "Standard_B1s"
}

variable "vm_image" {
  description = "VM image"
  type        = string
  default     = "0001-com-ubuntu-server-jammy"
}

variable "vm_sku" {
  description = "VM SKU"
  type        = string
  default     = "22_04-lts-gen2"
}

variable "admin_username" {
  description = "Admin username for VMs"
  type        = string
  default     = "azureuser"
}

# VN check
variable "ping_script_path" {
  description = "Path to the ping script"
  type        = string
  default     = "./scripts/ping_script.sh"
}
