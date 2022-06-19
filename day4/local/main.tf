provider "aws"{
  region = "us-east-2"
}

variable "ami_id" {
  type = string
}

locals {
  project_name = "local_practice"
}

resource "aws_instance" "localExample"{
  ami = var.ami_id
  #count = 5
  instance_type = "t2.micro"
  tags = {
    Name = "MyServer-${local.project_name}"
  }
}

output "instance_public_ip" {
  value = aws_instance.localExample.public_ip
}