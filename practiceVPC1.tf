provider "aws"{
  region = "us-east-2"
}

resource "aws_vpc" "myVpc"{
    cidr_block = "10.0.0.0/16"
    instance_tenancy = "default"
    tags  = {
        Name = "myVpc"
    }
}

resource "aws_subnet" "public-subnet" {
    vpc_id = aws_vpc.myVpc.id
    cidr_block = "10.0.1.0/24"
    tags = {
      Name = "public-subnet"
    }
}

resource "aws_subnet" "private-subnet" {
    vpc_id = aws_vpc.myVpc.id
    cidr_block = "10.0.2.0/24"
    tags = {
      Name = "private-subnet"
    }
}
