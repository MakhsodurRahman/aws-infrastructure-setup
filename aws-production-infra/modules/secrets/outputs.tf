output "db_secret_arn" {
  description = "The ARN of the DB secret"
  value       = aws_secretsmanager_secret.db_credentials.arn
}

output "redis_secret_arn" {
  description = "The ARN of the Redis secret"
  value       = aws_secretsmanager_secret.redis_password.arn
}

output "db_password" {
  description = "The database password stored in the secret"
  value       = var.db_password
  sensitive   = true
}
