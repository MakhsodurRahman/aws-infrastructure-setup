output "backend_ecr_url" {
  value = module.ecr.backend_repo_url
}

output "frontend_ecr_url" {
  value = module.ecr.frontend_repo_url
}

output "backend_eb_url" {
  value = module.elastic_beanstalk.backend_url
}


output "frontend_s3_bucket" {
  value = module.s3_cloudfront.bucket_name
}

output "frontend_cloudfront_domain" {
  value = module.s3_cloudfront.cloudfront_domain_name
}

output "frontend_cloudfront_id" {
  value = module.s3_cloudfront.cloudfront_distribution_id
}
