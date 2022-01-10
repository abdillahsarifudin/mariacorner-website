terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }

  cloud {
    organization = "mariacorner"

    workspaces {
      name = "mariacorner-prod-website"
    }
  }
}