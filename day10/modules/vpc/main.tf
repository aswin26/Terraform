resource "aws_vpc" "my-vpc" {
  cidr_block       = var.cidr_block
  instance_tenancy = "default"

  tags = {
    Name = "my-vpc"
  }
}

resource "aws_subnet" "public-subnet" {
  vpc_id     = aws_vpc.my-vpc.id
  cidr_block = var.public_subnet
availability_zone = var.public_az
  tags = {
    Name = "public-subnet"
  }
}

resource "aws_subnet" "private-subnet" {
  vpc_id     = aws_vpc.my-vpc.id
  cidr_block = var.private_subnet
availability_zone = var.private_az
  tags = {
    Name = "private-subnet"
  }
}

resource "aws_internet_gateway" "gw-public" {
  vpc_id = aws_vpc.my-vpc.id

  tags = {
    Name = "gw-public"
  }
}


resource "aws_route_table" "rt-public" {
  vpc_id = aws_vpc.my-vpc.id
  
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw-public.id
  }

#   route {
#     ipv6_cidr_block        = "::/0"
#     egress_only_gateway_id = aws_egress_only_internet_gateway.example.id
#   }

  tags = {
    Name = "rt-public"
  }
}

resource "aws_route_table_association" "a1" {
  subnet_id      = aws_subnet.public-subnet.id
  route_table_id = aws_route_table.rt-public.id
}


resource "aws_route_table" "rt-private" {
  vpc_id = aws_vpc.my-vpc.id
  
#   route {
#     cidr_block = "0.0.0.0/0"
#     gateway_id = aws_internet_gateway.gw-public.id
#   }

#   route {
#     ipv6_cidr_block        = "::/0"
#     egress_only_gateway_id = aws_egress_only_internet_gateway.example.id
#   }

  tags = {
    Name = "rt-private"
  }
}

resource "aws_route_table_association" "a2" {
  subnet_id      = aws_subnet.private-subnet.id
  route_table_id = aws_route_table.rt-private.id
}


locals {
    ingress_rules = [{
        port = 22
        description = "Ingress rule for 22 port"
    },
    {
        port = 443
        description = "Ingress rule for 443 port"
    }
    ]
}

resource "aws_security_group" "web_instance_sg" {
  description = "allows all http and ssh requests"
  name = "web_instance_sg"
  vpc_id = aws_vpc.my-vpc.id
  dynamic "ingress"{
    for_each = local.ingress_rules
    content{
        description = ingress.value.description
        from_port = ingress.value.port
        to_port = ingress.value.port
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    from_port = 0
    to_port = 65535
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "web_instance_sg"
  }
}


output "vpc_id" {
  value = aws_vpc.my-vpc.id
}

output "public_subnet" {
  value = aws_subnet.public-subnet.id
}

output "sg_id" {
  value = aws_security_group.web_instance_sg.id
}