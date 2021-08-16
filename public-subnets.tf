resource "aws_subnet" "public_subnets" {
  count             = length(local.az_names)
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = cidrsubnet(var.vpc_cidr, 4, count.index)
  availability_zone = local.az_names[count.index]
  map_public_ip_on_launch = true
  tags = {
    Name = "${terraform.workspace}-public-subnet-${count.index + 1}"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    Name = "${terraform.workspace}-igw"
  }
}

resource "aws_route_table" "my-prt" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "${terraform.workspace}-prt"
  }
}

resource "aws_route_table_association" "pub-sub-association" {
  count = length(local.az_names)
  subnet_id      = local.pub_sub_ids[count.index]
  route_table_id = aws_route_table.my-prt.id
}
