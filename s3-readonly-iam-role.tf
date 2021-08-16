data "template_file" "s3readonly_policy" {
  template = "${file("scripts/iam/s3-readonly.json")}"
}

resource "aws_iam_role_policy" "s3readonly_policy" {
  name = "s3readonly_policy"
  role = aws_iam_role.s3readonly_role.id

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = data.template_file.s3_policy.rendered
}

resource "aws_iam_role" "s3readonly_role" {
  name = "ss3readonly_role"

  assume_role_policy = file("scripts/iam/web-ec2-assume-role.json")
}


resource "aws_iam_instance_profile" "s3readonly_profile" {
  name = "s3readonly_profile"
  role = aws_iam_role.s3readonly_role.name
}
