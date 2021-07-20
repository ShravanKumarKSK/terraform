terraform {
  required_version = "~> 1.0" # which means any version equal & above 0.14 like 0.15, 0.16 etc and < 1.xx
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

# acc=AKIAWOLBAFTBOJSHY4UP
# sec =Ogagf8kZvReZbeW+QaItv+qGqPrwzuklr9b37ZVm

provider "aws" {
  access_key = "AKIAWOLBAFTBOJSHY4UP"
  secret_key = "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"
  region = "us-east-2"

}






resource "aws_instance" "my-ec2-vm" {
  ami           = "ami-0c773e57bf5bbd7a3"
  # aws_region        = var.aws_reg
  instance_type = var.inst_type
  count = 1
  key_name      = "ohioterraform.pem"
  user_data = file("apache.sh")
  vpc_security_group_ids = [aws_security_group.vpc-ssh.id, aws_security_group.vpc-web.id]
  tags = {
    "Name" = "Terraform-Cloud"
  }
}


variable "aws_reg" {
  description = "region names"
  type = string
}

variable "inst_type" {
  description = "instance typee"
  # default = ""
  type = string
}
