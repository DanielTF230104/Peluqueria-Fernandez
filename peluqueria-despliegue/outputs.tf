output "bastion_public_ip" {
  value = aws_instance.Bastion.public_ip
}

output "frontend_private_ip" {
  value = aws_instance.Frontend.private_ip
}

output "api_private_ip" {
  value = aws_instance.Api.private_ip
}