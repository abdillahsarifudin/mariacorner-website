terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
  required_version = ">= 1.1.0"

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