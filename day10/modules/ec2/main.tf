resource "aws_instance" "web_instance" {
  ami = var.ami_id
  instance_type = var.instance_type
  key_name = var.key_name
  security_groups = ["web_instance_sg"]
  subnet_id = var.subnet_id
  associate_public_ip_address = var.associate_public_ip
  count = var.counts
  tags = {
    Name = "server ${count.index+1}"
  }
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
  vpc_id = var.vpc_id
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
}
