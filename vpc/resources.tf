resource "aws_vpc" "primary" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"

  tags = {
    Name = "myvpc"
  }
}

resource "aws_subnet" "subnets" {
  count             = length(var.subnets_cidr)
  vpc_id            = aws_vpc.primary.id
  cidr_block        = var.subnets_cidr[count.index]
  availability_zone = var.subnets_azs[count.index]


  tags = {
    Name = var.subnet_tags[count.index]
  }
}

resource "aws_security_group" "websg" {
  name        = "web_security_group"
  description = "security group for ec2 instance"
  vpc_id      = aws_vpc.primary.id

  ingress {
    from_port        = local.ssh
    to_port          = local.ssh
    protocol         = "tcp"
    cidr_blocks      = [local.anywhere]
    
  }

  ingress {
    from_port        = local.http
    to_port          = local.http
    protocol         = "tcp"
    cidr_blocks      = [local.anywhere]
    
  }
  ingress {
    from_port        =  local.https
    to_port          =  local.https
    protocol         = "tcp"
    cidr_blocks      = [local.anywhere]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = [local.anywhere]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "websg"
  }
}


  resource "aws_security_group" "dbsg" {
  name        = "sg for database"
  vpc_id      = aws_vpc.primary.id

  ingress {
    from_port        = 5432
    to_port          = 5432
    protocol         = "tcp"
    cidr_blocks      = [var.vpc_cidr]
    
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = [local.anywhere]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "dbsg"
  }
}

  
