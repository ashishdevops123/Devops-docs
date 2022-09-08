output "vpc_id" {
    value = aws_vpc.primary.id
  
}

output "publicsg_id" {
    value = aws_security_group.websg.id
  
}
output "privatesg_id" {
    value = aws_security_group.dbsg.id
  
}
output "ec2instance" {
    value  = aws_instance.webinstance.public_ip
  
}
output "ec2url" {
    value = format("ssh -i %s.pem ubuntu@%s", "terraform" ,aws_instance.webinstance.public_ip)
  
}