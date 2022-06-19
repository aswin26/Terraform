terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.19.0"
    }
  }
}

provider "aws"{
  profile = "default"
  region = "us-east-2"
}

provider "aws"{
  profile = "default"
  region = "eu-west-1"
  alias = "eu"
}
