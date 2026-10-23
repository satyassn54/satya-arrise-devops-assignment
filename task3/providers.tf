terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  alias   = "account_a"
  region  = "ap-south-2"
  profile = var.account_a_profile
}

provider "aws" {
  alias   = "account_b"
  region  = "ap-south-2"
  profile = var.account_b_profile
}
