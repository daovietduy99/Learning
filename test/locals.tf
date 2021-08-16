locals {
  vpc_name = "${terraform.workspace}-vpc"
  az_names = data.aws_availability_zones.azs.names
}