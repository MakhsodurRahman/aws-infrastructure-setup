output "secret_arn" {
  description = "The ARN of the secret"
  value       = aws_secretsmanager_secret.db_credentials.arn
}

output "secret_name" {
  description = "The name of the secret"
  value       = aws_secretsmanager_secret.db_credentials.name
}

output "db_password" {
  description = "The database password stored in the secret"
  value       = var.db_password
  sensitive   = true
}
