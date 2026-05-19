terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }

  required_version = ">= 1.2"
}

provider "aws" {
  region = var.region
}

/*-------------- BASTIÓN ----------------------*/
resource "aws_instance" "Bastion" {
    ami           = data.aws_ami.ubuntu.id
    key_name      = var.key_name
    instance_type = "t2.micro"
    tags          = { Name = "Bastion-Peluqueria" }
    
    user_data = file("scripts/bastion.sh")
    vpc_security_group_ids = [aws_security_group.GS_Bastion.id, aws_security_group.FROM_Bastion.id]
}

/*------------- FRONTEND  -----------*/
resource "aws_instance" "Frontend" {
    ami           = data.aws_ami.ubuntu.id
    key_name      = var.key_name
    instance_type = var.instance_type_web
    tags          = { Name = "Frontend-Angular" }

    vpc_security_group_ids = [aws_security_group.GS_Front.id, aws_security_group.FROM_Front.id]
    
    user_data = templatefile("scripts/front.tftpl", { 
        api_dns = aws_route53_record.api.fqdn 
    })
}

/*---------------- API ---------------*/
resource "aws_instance" "Api" {
    ami           = data.aws_ami.ubuntu.id
    key_name      = var.key_name
    instance_type = var.instance_type_web
    tags          = { Name = "API-Laravel" }

    vpc_security_group_ids = [aws_security_group.GS_Api.id]
    user_data = file("scripts/api.sh") 
}

/*--- GRUPOS PARA EL BASTIÓN ---*/
resource "aws_security_group" "GS_Bastion" {
  name        = "GS_Bastion_Peluqueria"
  description = "Reglas de entrada y salida para el bastion"
  vpc_id      = data.aws_vpc.defaultNetwork.id
}

resource "aws_security_group" "FROM_Bastion" {
  name        = "FROM_Bastion_Peluqueria"
  description = "Grupo para identificar al bastion ante los otros servidores"
  vpc_id      = data.aws_vpc.defaultNetwork.id
}

/*--- GRUPOS PARA EL FRONTEND ---*/
resource "aws_security_group" "GS_Front" {
  name        = "GS_Front_Peluqueria"
  description = "Reglas para el servidor de Angular"
  vpc_id      = data.aws_vpc.defaultNetwork.id
}

resource "aws_security_group" "FROM_Front" {
  name        = "FROM_Front_Peluqueria"
  description = "Grupo para identificar al front ante la API"
  vpc_id      = data.aws_vpc.defaultNetwork.id
}

/*--- GRUPOS PARA LA API ---*/
resource "aws_security_group" "GS_Api" {
  name        = "GS_Api_Peluqueria"
  description = "Reglas para el servidor de Laravel"
  vpc_id      = data.aws_vpc.defaultNetwork.id
}

resource "aws_vpc_security_group_ingress_rule" "ssh_bastion" {
  cidr_ipv4         = var.any_ip
  from_port         = 22
  to_port           = 22
  ip_protocol       = "tcp"
  security_group_id = aws_security_group.GS_Bastion.id
}

resource "aws_vpc_security_group_egress_rule" "all_bastion" {
  cidr_ipv4         = var.any_ip
  ip_protocol       = "-1"
  security_group_id = aws_security_group.GS_Bastion.id
}

// SSH solo desde Bastión
resource "aws_vpc_security_group_ingress_rule" "ssh_front_from_bastion" {
  referenced_security_group_id = aws_security_group.FROM_Bastion.id
  from_port                    = 22
  to_port                      = 22
  ip_protocol                  = "tcp"
  security_group_id            = aws_security_group.GS_Front.id
}

// HTTP abierto al público
resource "aws_vpc_security_group_ingress_rule" "http_front" {
  cidr_ipv4         = var.any_ip
  from_port         = 80
  to_port           = 80
  ip_protocol       = "tcp"
  security_group_id = aws_security_group.GS_Front.id
}

resource "aws_vpc_security_group_egress_rule" "all_front" {
  cidr_ipv4         = var.any_ip
  ip_protocol       = "-1"
  security_group_id = aws_security_group.GS_Front.id
}

// SSH solo desde Bastión
resource "aws_vpc_security_group_ingress_rule" "ssh_api_from_bastion" {
  referenced_security_group_id = aws_security_group.FROM_Bastion.id
  from_port                    = 22
  to_port                      = 22
  ip_protocol                  = "tcp"
  security_group_id            = aws_security_group.GS_Api.id
}

// HTTP solo desde el Frontend
resource "aws_vpc_security_group_ingress_rule" "http_api_from_front" {
  referenced_security_group_id = aws_security_group.FROM_Front.id
  from_port                    = 80
  to_port                      = 80
  ip_protocol                  = "tcp"
  security_group_id            = aws_security_group.GS_Api.id
}

resource "aws_vpc_security_group_egress_rule" "all_api" {
  cidr_ipv4         = var.any_ip
  ip_protocol       = "-1"
  security_group_id = aws_security_group.GS_Api.id
}

/*--- GRUPO PARA LA BASE DE DATOS ---*/
resource "aws_security_group" "GS_Database" {
  name        = "GS_Database_Peluqueria"
  description = "Solo permite entrada desde el servidor API"
  vpc_id      = data.aws_vpc.defaultNetwork.id
}

// Regla: Solo la API entra al puerto 3306
resource "aws_vpc_security_group_ingress_rule" "mysql_from_api" {
  referenced_security_group_id = aws_security_group.GS_Api.id
  from_port                    = 3306
  to_port                      = 3306
  ip_protocol                  = "tcp"
  security_group_id            = aws_security_group.GS_Database.id
}

resource "aws_db_instance" "mysql_db" {
  allocated_storage    = 20
  db_name              = "peluqueria_db"
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t3.micro"
  username             = var.db_user
  password             = var.db_pass
  parameter_group_name = "default.mysql8.0"
  skip_final_snapshot  = true
  publicly_accessible  = false
  vpc_security_group_ids = [aws_security_group.GS_Database.id]
}

resource "aws_route53_record" "db" {
  zone_id = aws_route53_zone.peluqueria_dns.id
  name    = "db"
  type    = "CNAME"
  ttl     = 300
  records = [aws_db_instance.mysql_db.address]
}

resource "aws_route53_zone" "peluqueria_dns" {
  name = var.zone_name
  vpc { vpc_id = data.aws_vpc.defaultNetwork.id }
}

resource "aws_route53_record" "api" {
  zone_id = aws_route53_zone.peluqueria_dns.id
  name    = "api"
  type    = "A"
  ttl     = 300
  records = [aws_instance.Api.private_ip]
}

resource "aws_route53_record" "frontend" {
  zone_id = aws_route53_zone.peluqueria_dns.id
  name    = "frontend"
  type    = "A"
  ttl     = 300
  records = [aws_instance.Frontend.private_ip]
}