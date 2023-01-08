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

resource "aws_security_group_rule" "vpn_ingress" {
  type                     = "ingress"
  description              = "Ingress port used for clients to connect with the VPN."
  from_port                = var.wireguard_traffic_port
  to_port                  = var.wireguard_traffic_port
  protocol                 = "tcp"
  cidr_blocks              = [data.aws_vpc.vpc.cidr_block]
  security_group_id        = aws_security_group.observability_hub_security_group.id
}