data "aws_ami" "fedora_coreos" {
  most_recent = true
  owners      = [var.ami_owner] // Fedora Core OS 

  filter {
    name   = "name"
    values = [var.ami_id]
  }
}