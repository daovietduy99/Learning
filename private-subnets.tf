
resource "aws_subnet" "private_subnets" {
  count             = length(slice(local.az_names, 0, 2))
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = cidrsubnet(var.vpc_cidr, 4, count.index + length(local.az_names))
  availability_zone = local.az_names[count.index]
  tags = {
    Name = "${terraform.workspace}-private-subnet-${count.index + 1}"
  }
}
resource "aws_instance" "nat_instance" {
  ami           = var.ami
  instance_type = "t2.micro"
  subnet_id = local.pub_sub_ids[0]
  source_dest_check = false
  security_groups = [aws_security_group.nat_sg.id]

  tags = {
    Name = "${terraform.workspace}-nat"
  }
}

resource "aws_route_table" "pri_rt" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    instance_id = aws_instance.nat_instance.id
  }

  tags = {
    Name = "${terraform.workspace}-pri-prt"
  }
}

resource "aws_route_table_association" "pri-sub-association" {
  count = length(slice(local.az_names, 0, 2))
  subnet_id      = aws_subnet.private_subnets.*.id[count.index]
  route_table_id = aws_route_table.pri_rt.id
}

resource "aws_security_group" "nat_sg" {
  name        = "nat_sg"
  description = "Allow traffic for provate subnets"
  vpc_id      = aws_vpc.my_vpc.id

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }


  tags = {
    Name = "${terraform.workspace}-pri-sg"
  }
}