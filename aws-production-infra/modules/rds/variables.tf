variable "project_name" {
  description = "Project name"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "vpc_id" {
  description = "The VPC ID"
  type        = string
}

variable "public_subnet_ids" {
  description = "List of public subnet IDs for RDS"
  type        = list(string)
}

variable "ec2_sg_id" {
  description = "The security group ID of the EC2 instances"
  type        = string
}

variable "db_name" {
  description = "The name of the database"
  type        = string
  default     = "chat_db"
}

variable "db_username" {
  description = "Username for the master DB user"
  type        = string
  default     = "chatdbuser"
}

variable "db_password" {
  description = "Password for the master DB user"
  type        = string
  sensitive   = true
}

variable "instance_class" {
  description = "The instance type of the RDS instance"
  type        = string
  default     = "db.t3.micro"
}

variable "allocated_storage" {
  description = "The allocated storage in gigabytes"
  type        = number
  default     = 20
}

variable "common_tags" {
  description = "Common tags for all resources"
  type        = map(string)
  default     = {}
}
