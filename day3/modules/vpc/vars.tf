variable "vpc_cidr"{
    default = "10.0.0.0/16"
}

variable "tenancy" {
  default = "default"
}

variable "vpc_id" {}

variable "public_subnet_cidr" {
  default = "10.0.1.0/24"
}