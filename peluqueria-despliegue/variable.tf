variable "region" { default = "us-east-1" }
variable "key_name" { default = "vockey" }
variable "instance_type_web" { default = "t2.medium" }
variable "any_ip" { default = "0.0.0.0/0" }
variable "zone_name" { default = "peluqueriafernandez.com" }
variable "db_user" { default = "admin_pelu" }
variable "db_pass" { default = "Peluqueria2026*" }

data "aws_vpc" "defaultNetwork" {
  default = true
}

data "aws_ami" "ubuntu" {
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
  owners = ["099720109477"] # Canonical
}