output "wireguard_vpn_security_group_id" {
  value       = aws_security_group.wireguard_vpn.id
  description = "Security ID used for adding rules in other modules."
}