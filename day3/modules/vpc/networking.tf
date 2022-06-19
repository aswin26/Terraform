resource "aws_vpc" "main" {

  cidr_block       = "${var.vpc_cidr}"
  instance_tenancy = "${var.tenancy}"

  tags = {
    Name = "main"
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id     = "${var.vpc_id}"
  cidr_block = "${var.public_subnet_cidr}"

  tags = {
    Name = "public_subnet"
  }
}

output "vpc_id" {
  value = "${aws_vpc.main.id}"
}

output "subnet_id" {
    value = "${aws_subnet.public_subnet.id}"
}
