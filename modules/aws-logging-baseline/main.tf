########################################
# S3 Log Bucket
########################################

resource "aws_s3_bucket" "log_bucket" {
  bucket = "${var.environment}-platform-audit-logs"

  lifecycle {
    prevent_destroy = true
  }

  tags = {
    Name        = "${var.environment}-audit-logs"
    Environment = var.environment
  }
}

########################################
# Versioning
########################################

resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.log_bucket.id

  versioning_configuration {
    status = "Enabled"
  }
}

########################################
# Encryption
########################################

resource "aws_s3_bucket_server_side_encryption_configuration" "encryption" {
  bucket = aws_s3_bucket.log_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

########################################
# Public Access Block
########################################

resource "aws_s3_bucket_public_access_block" "block_public" {
  bucket = aws_s3_bucket.log_bucket.id

  block_public_acls   = true
  block_public_policy = true
  ignore_public_acls  = true
  restrict_public_buckets = true
}

########################################
# CloudTrail
########################################

resource "aws_cloudtrail" "this" {
  name                          = "${var.environment}-platform-trail"
  s3_bucket_name                = aws_s3_bucket.log_bucket.id
  include_global_service_events = true
  is_multi_region_trail         = true
  enable_logging                = true

  event_selector {
    read_write_type           = "All"
    include_management_events = true
  }

  depends_on = [
    aws_s3_bucket_public_access_block.block_public
  ]
}
