terraform {
  required_version = ">= 1.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  # Replace these with your actual S3 bucket and DynamoDB table
  # backend "s3" {
  #   bucket         = "YOUR_BOOTSTRAPPED_STATE_BUCKET"
  #   key            = "dev/terraform.tfstate"
  #   region         = "us-east-1"
  #   dynamodb_table = "YOUR_BOOTSTRAPPED_LOCK_TABLE"
  #   encrypt        = true
  # }
}

provider "aws" {
  region = var.aws_region
}

locals {
  common_tags = {
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}

module "vpc" {
  source = "../../modules/vpc"

  project_name         = var.project_name
  environment          = var.environment
  vpc_cidr             = var.vpc_cidr
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  availability_zones   = var.availability_zones
  common_tags          = local.common_tags
}

module "alb" {
  source = "../../modules/alb"

  project_name      = var.project_name
  environment       = var.environment
  vpc_id            = module.vpc.vpc_id
  public_subnet_ids = module.vpc.public_subnet_ids
  common_tags       = local.common_tags
}

module "docker" {
  source = "../../modules/docker"
}

module "autoscaling" {
  source = "../../modules/autoscaling"

  project_name          = var.project_name
  environment           = var.environment
  vpc_id                = module.vpc.vpc_id
  private_subnet_ids    = module.vpc.public_subnet_ids # Switched to public for direct Redis access
  target_group_arn      = module.alb.target_group_arn
  alb_security_group_id = module.alb.alb_security_group_id
  instance_type         = var.instance_type
  min_size              = 1
  max_size              = 3
  desired_capacity      = 1
  redis_secret_arn      = module.secrets.redis_secret_arn
  docker_install_script = module.docker.install_script
  common_tags           = local.common_tags
}

module "s3" {
  source = "../../modules/s3"

  project_name = var.project_name
  environment  = var.environment
  common_tags  = local.common_tags
}

module "secrets" {
  source = "../../modules/secrets"

  project_name = var.project_name
  environment  = var.environment
  db_username  = "chatdbuser"
  db_password  = var.db_password
  db_name      = "chat_db"
  common_tags  = local.common_tags
}

module "rds" {
  source = "../../modules/rds"

  project_name      = var.project_name
  environment       = var.environment
  vpc_id            = module.vpc.vpc_id
  public_subnet_ids = module.vpc.public_subnet_ids
  ec2_sg_id         = module.autoscaling.ec2_sg_id
  db_password       = module.secrets.db_password
  common_tags       = local.common_tags
}
