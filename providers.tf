terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
    }
    random = {
      source = "hashicorp/random"
    }
  }

  cloud {
    organization = "mariacorner"

    workspaces {
      name = "mariacorner-prod-website"
    }
  }
}

provider "aws" {
  region = "ap-southeast-1"
}