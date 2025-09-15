# Note: This is a demo file with intentional security misconfigurations
# No providers are actually configured - this is for scanning demonstration only

resource "aws_s3_bucket" "data" {
  bucket = "build-breaker-demo-bucket"
  # SECURITY ISSUE: Public access enabled
  acl    = "public-read"
}

resource "aws_s3_bucket_public_access_block" "data" {
  bucket = aws_s3_bucket.data.id
  
  # SECURITY ISSUE: All public access blocks disabled
  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_security_group" "app" {
  name        = "app-sg"
  description = "Security group for demo app"

  # SECURITY ISSUE: Open SSH access from anywhere
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
