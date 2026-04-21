variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "frontend_bucket_name" {
  description = "Name for the S3 bucket intended to host the frontend React app."
  type        = string
  default     = "messaging-frontend-unique-id" # CHANGE THIS to something globally unique
}
