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

variable "wireguard_vpn_image" {
  type        = string
  default     = "docker.io/weejewel/wg-easy@sha256:ea65f283dfeb62628ce942ce38974f9db05177aa27ab69b787115b78591552f3"
  description = "The wireguard oci image location used for pulling the image."
}

variable "wireguard_wg_host" {
  type        = string
  default     = "192.168.178.55"
  description = "The wireguard host used for the vpn."
}

variable "wireguard_password" {
  type        = string
  default     = "testingtesting"
  description = "The wireguard password used for accesing the dashboard."
}

variable "wireguard_prometheus_exporter_image_repository" {
  type        = string
  default     = "docker.io/mindflavor/prometheus-wireguard-exporter"
  description = "OCI image repository for Wireguard Prometheus exporter."
}

variable "wireguard_prometheus_exporter_image_version" {
  type        = string
  default     = "3.6.6"
  description = "OCI image version or tag for Wireguard Prometheus exporter."
}

variable "wireguard_prometheus_port" {
  type        = number
  default     = 9586
  description = "Wireguard Prometheus port, used for metrics."
}

variable "authorized_key" {
  type        = string
  default     = ""
  description = "SSH key used to grant access to the machine spawned with this configuration."
}

variable "node_exporter_image_name" {
  type        = string
  default     = "docker.io/prom/node-exporter:latest"
  description = "The node exporter oci image location used for exposing metrics."
}

variable "instance_type" {
  type        = string
  default     = "t3.small"
}

variable "instance_volume_size" {
  type        = number
  default     = 20
}

variable "instance_desired_count" {
  type        = number
  default     = 1 
}

variable "instance_max_count" {
  type        = number
  default     = 1
}

variable "instance_min_count" {
  type        = number
  default     = 1
}