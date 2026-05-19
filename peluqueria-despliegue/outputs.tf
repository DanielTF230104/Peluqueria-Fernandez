output "bastion_public_ip" {
  value = aws_instance.Bastion.public_ip
}

output "frontend_private_ip" {
  value = aws_instance.Frontend.private_ip
}

output "api_private_ip" {
  value = aws_instance.Api.private_ip
}

output "frontend_public_elastic_ip" {
  value = aws_eip.front_elastic_ip.public_ip
}

output "api_public_elastic_ip" {
  value = aws_eip.api_elastic_ip.public_ip
}