variable "vpc_id" {}
variable "public_subnets" { type = list(string) }
variable "private_subnets" { type = list(string) }
variable "instance_profile" {}

# Backend Application
resource "aws_elastic_beanstalk_application" "backend" {
  name        = "messaging-backend"
  description = "Backend Spring Boot application"
}

resource "aws_elastic_beanstalk_environment" "backend_env" {
  name                = "messaging-backend-prod"
  application         = aws_elastic_beanstalk_application.backend.name
  solution_stack_name = "64bit Amazon Linux 2023 v4.11.1 running Corretto 21"

  setting {
    namespace = "aws:ec2:vpc"
    name      = "VPCId"
    value     = var.vpc_id
  }

  setting {
    namespace = "aws:ec2:vpc"
    name      = "Subnets"
    value     = join(",", var.public_subnets)
  }

  setting {
    namespace = "aws:ec2:vpc"
    name      = "AssociatePublicIpAddress"
    value     = "true"
  }

  setting {
    namespace = "aws:ec2:vpc"
    name      = "ELBSubnets"
    value     = join(",", var.public_subnets)
  }

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "IamInstanceProfile"
    value     = var.instance_profile
  }

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "InstanceType"
    value     = "c7i-flex.large"
  }

  setting {
    namespace = "aws:elasticbeanstalk:environment"
    name      = "LoadBalancerType"
    value     = "application"
  }
}

output "backend_url" {
  value = aws_elastic_beanstalk_environment.backend_env.endpoint_url
}

