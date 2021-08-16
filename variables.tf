variable "vpc_cidr" {
  description = "Choose cidr for VPC"
  default     = "10.0.0.0/16"
}

variable "region" {
  description = "Choose region for your stack"
  type        = string
  default     = "ap-southeast-1"
}

variable "ami" {
  description = "Choose ami for your instance"
  type = string
  default = "ami-0f511ead81ccde020"
}

variable "web_ec2_count" {
  description = "Choose bumber ec2 instances for web"
  type        = string
  default     = "2"
}
