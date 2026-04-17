# Provider block
provider "aws" {
  region = var.aws_region
}

# S3 Bucket resource
resource "aws_s3_bucket" "pc_bucket" {
  bucket = var.bucket_name

  tags = {
    Name        = var.bucket_name
    Environment = "Dev"
  }
}

# Versioning & Encryption (Best Practice but optional)
resource "aws_s3_bucket_versioning" "pc_bucket_versioning" {
  bucket = aws_s3_bucket.pc_bucket.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "pc_bucket_encryption" {
  bucket = aws_s3_bucket.pc_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}
