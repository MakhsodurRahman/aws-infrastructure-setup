resource "aws_db_subnet_group" "this" {
  name       = "${var.project_name}-${var.environment}-rds-subnet-group"
  subnet_ids = var.public_subnet_ids # Using public subnets for public accessibility

  tags = merge(var.common_tags, {
    Name = "${var.project_name}-${var.environment}-rds-subnet-group"
  })
}

resource "aws_security_group" "rds_sg" {
  name        = "${var.project_name}-${var.environment}-rds-sg"
  description = "Security group for RDS PostgreSQL"
  vpc_id      = var.vpc_id

  # RULE 1: Public access from anywhere (Active for testing)
  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Public access for testing"
  }

  # RULE 2: Restricted access from EC2 instances (Commented out for later use)
  # ingress {
  #   from_port       = 5432
  #   to_port         = 5432
  #   protocol        = "tcp"
  #   security_groups = [var.ec2_sg_id]
  #   description     = "Restricted access from EC2 instances"
  # }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.common_tags, {
    Name = "${var.project_name}-${var.environment}-rds-sg"
  })
}

resource "aws_db_instance" "this" {
  identifier = "${var.project_name}-${var.environment}-db"
  
  engine            = "postgres"
  engine_version    = "15" # Using latest major version for production
  instance_class    = var.instance_class
  allocated_storage = var.allocated_storage
  storage_type      = "gp3"
  
  db_name  = var.db_name
  username = var.db_username
  password = var.db_password
  
  db_subnet_group_name   = aws_db_subnet_group.this.name
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  
  publicly_accessible = true # Enabled for testing as requested
  multi_az            = false # Single-AZ for Free Tier
  skip_final_snapshot = true
  
  backup_retention_period = 1
  backup_window           = "03:00-04:00"
  maintenance_window      = "Sun:05:00-Sun:06:00"
  
  deletion_protection = false # Usually true for prod, but false for easier dev/test cleanup

  tags = merge(var.common_tags, {
    Name = "${var.project_name}-${var.environment}-db"
  })
}
