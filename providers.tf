terraform {
  required_providers {
    hcp = {
      source  = "hashicorp/hcp"
      version = "~>0.48.0"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "~>4.39.0"
    }
  }
}

provider "hcp" {
}

provider "aws" {
}