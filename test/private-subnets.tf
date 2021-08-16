
resource "aws_subnet" "private_subnets" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = cidrsubnet(var.vpc_cidr, 4, 1)
  availability_zone = local.az_names[0]
  tags = {
    Name = "my-private-subnet-1"
  }
}