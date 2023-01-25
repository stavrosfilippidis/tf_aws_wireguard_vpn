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

variable "wireguard_client_port" {
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
  default     = "docker.io/prom/node-exporter@sha256:39c642b2b337e38c18e80266fb14383754178202f40103646337722a594d984c"
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

variable "wireguard_interface_name" {
  type        = string
  default     = "wg0"
  description = "Name of the Wireguard interface."
}

variable "wireguard_authorized_peers" {
  type = list(object({
    friendly_name = string
    public_key    = string
    allowed_ips   = string
  }))
  description = "List of authorized peers that are allowed to connect to the vpn."
}

variable "wireguard_interface_address" {
  type        = string
  description = "The Ip Address of the Wireguard VPN."
}

variable "wireguard_ingress_cidr_blocks" {
  type        = list(string)
  description = "List of CIDR blocks to authorize Wireguard to tunnel from."
  default     = ["0.0.0.0/0"]
}

variable "wireguard_private_key" {
  type        = string
  description = "Wireguard private key."
}

        # inline: |
        #   [Interface]
        #   PrivateKey = ${var.wireguard_private_key}
        #   Address = ${var.wireguard_interface_address}
        #   ListenPort = ${var.wireguard_port}
        #   MTU = 1420
        #   PostUp = iptables -A FORWARD -i wg0 -j ACCEPT; iptables -t nat -A POSTROUTING -o ens5 -j MASQUERADE; ip6tables -A FORWARD -i wg0 -j ACCEPT; ip6tables -t nat -A POSTROUTING -o ens5 -j MASQUERADE
        #   PostDown = iptables -D FORWARD -i wg0 -j ACCEPT; iptables -t nat -D POSTROUTING -o ens5 -j MASQUERADE; ip6tables -D FORWARD -i wg0 -j ACCEPT; ip6tables -t nat -D POSTROUTING -o ens5 -j MASQUERADE

        #   # Client: stav (92ec53a9-92e6-4809-8888-2910b1cb6698)
        #   [Peer]
        #   PublicKey = ${peer.public_key}
        #   AllowedIPs = ${peer.allowed_ips}

        # inline: |
        #   [Interface]
        #   PrivateKey = OJz+yhI/K8zX9LATiKdsGaP1jB2yj32GYr7dFJuDs3Q= 
        #   Address = 192.0.2.1/24 
        #   ListenPort = 51820
        #   MTU = 1420
        #   PostUp = iptables -A FORWARD -i wg0 -j ACCEPT; iptables -t nat -A POSTROUTING -o ens5 -j MASQUERADE; ip6tables -A FORWARD -i wg0 -j ACCEPT; ip6tables -t nat -A POSTROUTING -o ens5 -j MASQUERADE
        #   PostDown = iptables -D FORWARD -i wg0 -j ACCEPT; iptables -t nat -D POSTROUTING -o ens5 -j MASQUERADE; ip6tables -D FORWARD -i wg0 -j ACCEPT; ip6tables -t nat -D POSTROUTING -o ens5 -j MASQUERADE

        #   # Client: stav (92ec53a9-92e6-4809-8888-2910b1cb6698)
        #   [Peer]
        #   PublicKey = Q4LijXHxqNcTZA/iGyIxA3ra2lSZlQwYbcN0xcmdJCI=
        #   AllowedIPs = 192.0.2.1/32