provider "aws" {
  region = var.region
}

terraform {
  backend "s3" {
    bucket         = "terraform-remote-states-jkhfgdjkh"
    key            = "learning/terraform.tfstate"
    region         = "ap-southeast-1"
    dynamodb_table = "tf-lock"
  }
}