resource "aws_instance" "web_instance" {
  ami = var.ami_id
  instance_type = var.instance_type
  key_name = var.key_name
  vpc_security_group_ids = [var.sg_id]
  subnet_id = var.subnet_id
  associate_public_ip_address = var.associate_public_ip
  count = var.counts
  tags = {
    Name = "server ${count.index+1}"
  }
}
