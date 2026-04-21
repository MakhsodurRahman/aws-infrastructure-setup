terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

module "vpc" {
  source = "./modules/vpc"
}

module "ecr" {
  source = "./modules/ecr"
}

module "iam" {
  source = "./modules/iam"
}

module "elastic_beanstalk" {
  source           = "./modules/elastic_beanstalk"
  vpc_id           = module.vpc.vpc_id
  public_subnets   = module.vpc.public_subnet_ids
  private_subnets  = module.vpc.private_subnet_ids
  instance_profile = module.iam.instance_profile_name
}

module "s3_cloudfront" {
  source      = "./modules/s3_cloudfront"
  bucket_name = var.frontend_bucket_name
}
