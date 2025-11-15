provider "aws" {
    region = var.aws_region
    default_tags {
    tags = {
        "terraform" : true,
        "owner" : var.owner
    }
}
}

terraform {
    required_providers {
    aws = {
        source  = "hashicorp/aws"
        version = "~> 6.0"
    }
}
backend "s3" {}
}