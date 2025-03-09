variable "proxmox_url" {
  description = "The url for the Proxmox API"
  type        = string
  sensitive   = true
}

variable "pm_api_token_id" {
  description = "The token id for the Proxmox API"
  type        = string
  sensitive   = true
}

variable "pm_api_token_secret" {
  description = "The token secret for the Proxmox API"
  type        = string
  sensitive   = true
}

variable "cloud_init_username" {
  description = "The username for the cloud-init configuration"
  type        = string
  sensitive   = true
}

variable "cloud_init_password" {
  description = "The password for the cloud-init configuration"
  type        = string
  sensitive   = true
}
variable "cloud_init_searchdomain" {
  description = "The search domain for the cloud-init configuration"
  type        = string
  sensitive   = true
}
variable "cloud_init_nameserver" {
  description = "The nameserver for the cloud-init configuration"
  type        = string
  sensitive   = true
}
variable "cloud_init_sshkey" {
  description = "The ssh key for the cloud-init configuration"
  type        = string
  sensitive   = true
}
variable "cloud_init_ipconfig0" {
  description = "The ip configuration for the cloud-init configuration"
  type        = string
  sensitive   = true
}