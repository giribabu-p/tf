#Terraform 0.13 and later(v1.0)
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-west-2" #var.aws_region
}

/*
#terraform remote backend for storing tfstate file
terraform {
  backend "s3" {
    bucket = "pgb-demo-tf" #"terraform-pgb-demo2"
    key    = "dev/terraform.tfstate"
    region = "us-east-1"
  }
}

*/