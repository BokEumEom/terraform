# ------------------------------------------------------------------------------
# CREATE THE S3 BUCKET
# ------------------------------------------------------------------------------
resource "aws_s3_bucket" "s3_bucket" {
  # With account id, this S3 bucket names can be *globally* unique.
  bucket = "s3-${var.env_name[terraform.workspace]}.${var.product_name}.com"
  tags = {
    Terraform   = "true"
    Environment = "${var.env_name[terraform.workspace]}"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "s3_bucket" {
  bucket = aws_s3_bucket.s3_bucket.bucket

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_acl" "s3_bucket" {
  bucket = aws_s3_bucket.s3_bucket.id
  acl    = "private"
}

resource "aws_s3_bucket_versioning" "s3_bucket" {
  bucket = aws_s3_bucket.s3_bucket.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_public_access_block" "s3_bucket" {
  bucket = aws_s3_bucket.s3_bucket.id

  block_public_acls   = true
  block_public_policy = true
}

resource "aws_s3_bucket_policy" "s3_policy" {
  bucket = aws_s3_bucket.s3_bucket.id

  # Terraform's "jsonencode" function converts a
  # Terraform expression's result to valid JSON syntax.
  policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Id" : "PolicyId2",
      "Statement" : [
        {
          "Sid" : "AllowIPmix",
          "Effect" : "Allow",
          "Principal" : "*",
          "Action" : "s3:*",
          "Resource" : [
            "arn:aws:s3:::${aws_s3_bucket.s3_bucket.bucket}",
            "arn:aws:s3:::${aws_s3_bucket.s3_bucket.bucket}/*"
          ],
          "Condition" : {
            "IpAddress" : {
              "aws:SourceIp" : [
                "xxx.xxx.xxx.xxx/32",
              ]
            }
          }
        }
      ]
    }
  )
}