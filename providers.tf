terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
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