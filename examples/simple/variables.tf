variable "authorized_key" {
  type        = string
  default     = "<place your public ssh key>"
  description = "SSH key used to grant access to the machine spawned with this configuration."
}

variable "wireguard_private_key" {
  type        = string
  description = "Wireguard private key for the server configuration."
  default     = "<place your server private key>"
}

variable "wireguard_public_key" {
  type        = string
  description = "Wireguard client public key for configuring allowed peers."
  default     = "<place your server public key>"
}

variable "wireguard_interface_address" {
  type        = string
  description = "Wireguard interface address for the server."
  default     = "192.168.71.1/24"
}

variable "wireguard_cidr_block" {
  type        = string
  description = "CIDR block for the allowed ips on the client."
  default     = "192.168.71.0/24"
}

variable "wireguard_authorized_peers" {
  type = list(object({
    friendly_name = string
    public_key    = string
    allowed_ips   = string
  }))
  default     = []
  description = "List of authorized peers to authorize Wireguard tunneling from."
}

variable "wireguard_traffic_port" {
  type        = number
  default     = 51820
  description = "The Port used for the vpn to communicate."
}