
locals {
    workspace = read_terragrunt_config("workspace.hcl")
}



generate "provider" {
    path = "provider.tf"
    if_exists = "overwrite_terragrunt"
    contents = <<-EOF
    variable "region" {}

    provider "aws" {
        region = var.region
         default_tags {
            tags = {
                created_by = "terraform"
                orchestrated_by = "terragrunt"
                business_unit   = "platform"
            }
        }
    }
    terraform {
        required_providers {
            aws = {
                source  = "hashicorp/aws"
                version = ">= 3.0.0"
            }
            time = {
                source = "hashicorp/time"
                version = "~> 0.7.0"
            }
        }
    }

    EOF
}
