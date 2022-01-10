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

provider "aws" {
  version = "~>3.0"
  region  = "ap-southeast-1"
}