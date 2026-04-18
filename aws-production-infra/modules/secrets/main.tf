resource "aws_secretsmanager_secret" "db_credentials" {
  name        = "${var.project_name}-${var.environment}-db-credentials"
  description = "RDS database credentials for ${var.project_name}"

  tags = merge(
    var.common_tags,
    {
      Name = "${var.project_name}-${var.environment}-db-credentials"
    }
  )
}

resource "aws_secretsmanager_secret_version" "db_credentials_version" {
  secret_id = aws_secretsmanager_secret.db_credentials.id
  secret_string = jsonencode({
    username = var.db_username
    password = var.db_password
    dbname   = var.db_name
  })
}

resource "aws_secretsmanager_secret" "redis_password" {
  name        = "${var.project_name}-${var.environment}-redis-password"
  description = "Redis password for ${var.project_name}"

  tags = merge(
    var.common_tags,
    {
      Name = "${var.project_name}-${var.environment}-redis-password"
    }
  )
}

resource "aws_secretsmanager_secret_version" "redis_password_version" {
  secret_id     = aws_secretsmanager_secret.redis_password.id
  secret_string = var.db_password # Using the same password as requested: Makhsodur123
}
