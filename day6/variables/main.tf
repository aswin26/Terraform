provider "aws" {
  region = "us-west-1"
}

locals {
  ami = "ami-0d9858aa3c6322f73" 
}

variable "instance_type" {
  type = string
  description = "size of the instance"
#   sensitive = true
/*validation {
  condition = can(regex("^t2.",var.instance_type))
  error_message = "The instance must be a t2 instance."
}*/
}

resource "aws_instance" "web" {
  instance_type = var.instance_type
  ami = local.ami
}

output "public_ip" {
  value = aws_instance.web.public_ip
  sensitive = true
  description = "This is the public IP of web"
}