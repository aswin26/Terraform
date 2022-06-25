provider "aws" {
  region = "us-west-2"
}

resource "aws_instance" "instance_with_sg" {
  ami             = "ami-098e42ae54c764c35"
  instance_type   = "t2.micro"
  key_name        = "keyPair"
  security_groups = ["instance_sg"]
#   public_ip = aws_eip.public_ip
  count           = 2
  tags = {
    Name = "Instance "/*${count.index+1}"*/
  }
}

resource "aws_security_group" "instance_sg" {
  name        = "instance_sg"
  description = "allows all incoming TCP ports"

  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    description = "all incoming tcp ports"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    description = "all incoming tcp ports"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "instance_sg"
  }
}

resource "aws_eip" "public_ip" {
  for_each = toset(var.ec2_name)
    instance = aws_instance.instance_with_sg[each.key].id
    depends_on = [
      aws_instance.instance_with_sg
    ]
    # dynamic "setting"{
    #     for_each = aws_instance.instance_with_sg
        
    #     content{
    #         instance = setting.value.id
    #     }
    # }
   
}