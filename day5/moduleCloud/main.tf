terraform {
  cloud {
    organization = "terraform-learning-ak"

    workspaces {
      name = "terraform"
    }
  }
}

locals {
  project_name = "aswin"
}