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


