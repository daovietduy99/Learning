locals {
  mybucket = "my-bucket-fghfh5678gh"
}

resource "aws_s3_bucket" "my_bucket" {
  bucket = local.mybucket
  acl    = "private"

  tags = {
    Name        = "${terraform.workspace}-bucket"
    Environment = terraform.workspace
  }
}
