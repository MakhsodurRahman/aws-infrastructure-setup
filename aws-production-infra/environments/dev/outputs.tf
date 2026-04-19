output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnet_ids" {
  value = module.vpc.public_subnet_ids
}

output "private_subnet_ids" {
  value = module.vpc.private_subnet_ids
}

output "alb_dns_name" {
  value = module.alb.alb_dns_name
}

output "asg_name" {
  value = module.autoscaling.asg_name
}

output "s3_bucket_name" {
  value = module.s3.bucket_id
}

output "s3_bucket_arn" {
  value = module.s3.bucket_arn
}

output "rds_endpoint" {
  value = module.rds.db_instance_endpoint
}

output "docker_version_check_ssh" {
  description = "Run this command to check Docker version"
  value       = module.autoscaling.docker_version_check_ssh
}

output "docker_version" {
  description = "The assigned Docker version"
  value       = module.autoscaling.docker_version
}

output "nginx_version" {
  description = "The assigned Nginx version"
  value       = module.autoscaling.nginx_version
}
