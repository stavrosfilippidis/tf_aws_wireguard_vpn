variable "module_name" {
  type        = string
  default     = "wireguard_vpn"
  description = "The module name used throughout resources."
}

variable "vpc_id" {
  type        = string
  description = "VPC ID in which to deploy the service in."
}

variable "subnet_ids" {
  type        =  list(string)
  description = "List of subnet IDs to deploy the service in."
}

variable "ami_id" {
  type        = string
  default     = "fedora-coreos-37.20221211.3.0-x86_64"
  description = "The ami id specifying which Operating system to use."
}

variable "ami_owner" {
  type        = string
  default     = "125523088429"
  description = "The owner of the ami, in this particular case."
}

variable "wireguard_traffic_port" {
  type        = number
  default     = 51820
  description = "The Port used for the vpn to communicate."
}

variable "wireguard_dashboard_port" {
  type        = number
  default     = 51821
  description = "The Port used for accesing the Dashboard of the VPN."
}

variable "wireguard_image" {
  type        = string
  default     = "docker.io/weejewel/wg-easy@sha256:ea65f283dfeb62628ce942ce38974f9db05177aa27ab69b787115b78591552f3"
  description = "The wireguard oci image location used for the observability hub."
}

variable "wireguard_wg_host" {
  type        = string
  default     = "192.168.178.55"
  description = "The wireguard host used for the vpn."
}

variable "wireguard_wg_host" {
  type        = string
  default     = "test_password"
  description = "The wireguard passsword used for accesing the Dashboard."
}
