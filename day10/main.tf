module "aws_vpc" {
  source = "./modules/vpc"
  cidr_block = var.cidr_block
  public_subnet = var.public_subnet
  private_subnet = var.private_subnet
  public_az = var.public_az
  private_az = var.private_az
}

module "aws_ec2" {
  source = "./modules/ec2"
  ami_id = var.ami
  instance_type = var.instance_type
  count = var.counts
  associate_public_ip = var.associate_public_ip
  sg_id = module.aws_vpc.sg_id
  subnet_id = module.aws_vpc.public_subnet
  depends_on = [
    module.aws_vpc
  ]
}