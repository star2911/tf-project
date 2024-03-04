# output "bastion_host_public_ip" {
#   description = "Public IP address of the Bastion host"
#   value       = aws_instance.bastion_host.public_ip
# }
output "key_name" {
  value = aws_key_pair.bh-key.key_name
  
}
output "security_groups" {
 value = aws_security_group.star_sg.id 
}