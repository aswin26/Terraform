module "my_vpc" {
  source = "../modules/vpc"
  vpc_cidr = "192.168.0.0/16"
  tenancy = "default"
  vpc_id = "${module.my_vpc.vpc_id}"
  public_subnet_cidr = "192.168.1.0/24"
}


module "ec2_instance" {
  source = "../modules/ec2"
  ec2_count = "1"
  ami_id ="ami-098e42ae54c764c35"
  instance_type = "t2.micro"
  subnet_id = "${module.my_vpc.subnet_id}"
}