locals {
  wireguard_interface_name = "wg10"
  wireguard_cidr           = var.wireguard_cidr_block
  wireguard_client_address = cidrhost(local.wireguard_cidr, 2)
}


module "wireguard_vpn" {
  source = "../../"

  vpc_id                                 = data.aws_vpc.default.id
  subnet_ids                             = tolist(data.aws_subnet_ids.default.ids)
  authorized_key                         = var.authorized_key
  wireguard_private_key                  = var.wireguard_private_key
  wireguard_interface_address            = var.wireguard_interface_address 
  wireguard_authorized_peers             = concat(var.wireguard_authorized_peers, [{
    friendly_name                        = "vpn-client"
    public_key                           = "Q4LijXHxqNcTZA/iGyIxA3ra2lSZlQwYbcN0xcmdJCI="
    allowed_ips                          = local.wireguard_client_address
  }])
}

data "aws_vpc" "default" {
  default = true
}

data "aws_subnet_ids" "default" {
  vpc_id = data.aws_vpc.default.id

  filter {
    name   = "default-for-az"
    values = [true]
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
  profile = "default"
}
