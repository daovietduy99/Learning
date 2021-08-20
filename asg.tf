resource "aws_launch_template" "my_template" {
  name_prefix            = "my_template"
  image_id               = var.ami
  instance_type          = "t2.micro"
  key_name               = "nv-kp"
  user_data              = filebase64("scripts/user-data.sh")
  vpc_security_group_ids = [aws_security_group.asg_sg.id]
  iam_instance_profile {
    name = aws_iam_instance_profile.s3readonly_profile.name
  }
  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "${terraform.workspace}-template"
    }
  }
}

resource "aws_security_group" "asg_sg" {
  name        = "asg_sg"
  description = "Allow traffic for asg"
  vpc_id      = aws_vpc.my_vpc.id

  ingress {
    description = "http"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "ssh"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "asg_sg"
  }
}

resource "aws_autoscaling_group" "my_asg" {
  desired_capacity    = 2
  max_size            = 2
  min_size            = 2
  vpc_zone_identifier = local.pub_sub_ids
  target_group_arns   = [aws_lb_target_group.my_tg.arn]
  launch_template {
    id      = aws_launch_template.my_template.id
    version = "$Latest"
  }
}
