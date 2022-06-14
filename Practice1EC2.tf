provider "aws"{
	access_key = "A"
  secret_key = "CL"
  region = "us-east-2"
}

resource "aws_instance" "firstExample"{
  ami = "ami-0fa49cc9dc8d62c84"
  instance_type = "t2.micro"
  tags = {
    Name = "First-server"
    Environment = "dev"
  }
}

terraform {
  backend "s3"{
    bucket = "backupforterraform"
    key = "app/dev/terraform.tfstate"
    region = "us-east-2"
  }
}
