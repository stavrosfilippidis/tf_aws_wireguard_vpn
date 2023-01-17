resource "aws_security_group" "wireguard_vpn" {
  name     = "${var.module_name}_${random_string.uid.result}"

  description = "Allow all the necessary traffic to and from the VPN."
  vpc_id      = var.vpc_id
  
  tags = {
    Name                = "Wireguard VPN security group."
    TerraformWorkspace  = terraform.workspace
    TerraformModule     = basename(abspath(path.module))
    TerraformRootModule = basename(abspath(path.root))
  }
}

resource "aws_security_group_rule" "wireguard_prometheus_port" {
  type                     = "ingress"
  description              = "Ingress port used for scrapping metrics."
  from_port                = var.wireguard_prometheus_port
  to_port                  = var.wireguard_prometheus_port
  protocol                 = "tcp"
  cidr_blocks              = [data.aws_vpc.default.cidr_block]
  security_group_id        = aws_security_group.wireguard_vpn.id
}

resource "aws_security_group_rule" "vpn_ingress_tcp" {
  type                     = "ingress"
  description              = "Ingress port used for clients to connect with the VPN."
  from_port                = var.wireguard_traffic_port
  to_port                  = var.wireguard_traffic_port
  protocol                 = "tcp"
  cidr_blocks              = ["0.0.0.0/0"]
  security_group_id        = aws_security_group.wireguard_vpn.id
}

resource "aws_security_group_rule" "vpn_ingress_udp" {
  type                     = "ingress"
  description              = "Ingress port used for clients to connect with the VPN."
  from_port                = var.wireguard_traffic_port
  to_port                  = var.wireguard_traffic_port
  protocol                 = "udp"
  cidr_blocks              = ["0.0.0.0/0"]
  security_group_id        = aws_security_group.wireguard_vpn.id
}

resource "aws_security_group_rule" "ssh_access" {
  type                     = "ingress"
  description              = "Used to access the metrics collector over ssh."
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  cidr_blocks              = ["0.0.0.0/0"]
  security_group_id        = aws_security_group.wireguard_vpn.id
}
