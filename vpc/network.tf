resource "aws_internet_gateway" "ntierigw" {
  vpc_id = aws_vpc.primary.id

  tags = {
    Name = "internet gateway"
  }
}

resource "aws_route_table" "publicrt" {
  vpc_id = aws_vpc.primary.id
  tags        = {
    Name      = "public"
  }

  route {
    cidr_block = local.anywhere
    gateway_id = aws_internet_gateway.ntierigw.id
  }


    
}

resource "aws_route_table" "privatert" {
  vpc_id = aws_vpc.primary.id

tags = {
    Name = "privatert"
  }
 
}

resource "aws_route_table_association" "webrta1" {
  subnet_id      = aws_subnet.subnets[0].id
  route_table_id = aws_route_table.publicrt.id
}

resource "aws_route_table_association" "webrta2" {
  subnet_id      = aws_subnet.subnets[1].id
  route_table_id = aws_route_table.publicrt.id
}

resource "aws_route_table_association" "dbrta1" {
  subnet_id      = aws_subnet.subnets[2].id
  route_table_id = aws_route_table.privatert.id
}
resource "aws_route_table_association" "dbrta2" {
  subnet_id      = aws_subnet.subnets[3].id
  route_table_id = aws_route_table.privatert.id
}