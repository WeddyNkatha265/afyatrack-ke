terraform {
  required_version = ">= 1.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  # Backend configuration - this is where Terraform stores state
  backend "s3" {
    bucket = "afyatrack-ke-terraform-state"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}

provider "aws" {
  region = var.aws_region
  
  default_tags {
    tags = {
      Project     = "afyatrack-ke"
      Environment = "development"
      ManagedBy   = "terraform"
    }
  }
}