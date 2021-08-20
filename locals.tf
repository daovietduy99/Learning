locals {
  vpc_name    = "${terraform.workspace}-vpc"
  az_names    = data.aws_availability_zones.azs.names
  pub_sub_ids = aws_subnet.public_subnets.*.id
}