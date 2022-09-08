resource "aws_instance" "webinstance" {
  ami                          = "ami-0ddf424f81ddb0720"
  instance_type                = "t2.micro"
  associate_public_ip_address  = true
  key_name                     = "terraform"
  vpc_security_group_ids       = [aws_security_group.websg.id]
  subnet_id                    = aws_subnet.subnets[0].id

  tags = {
    Name = "Myec2instance"
  }
}