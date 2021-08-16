
# resource "aws_instance" "web" {
#   count = var.web_ec2_count
#   ami           = var.ami
#   instance_type = "t2.micro"
#   subnet_id = local.pub_sub_ids[count.index]
#   user_data = "${file("scripts/apache.sh")}"
#   iam_instance_profile = aws_iam_instance_profile.s3_ec2_profile.name
#   vpc_security_group_ids = [aws_security_group.web_sg.id]
#   key_name = "nv-kp"
#   tags = {
#     Name = "${terraform.workspace}-web"
#     Environment = terraform.workspace
#   }
# }
