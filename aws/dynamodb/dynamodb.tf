resource "aws_dynamodb_table" "table" {
  name         = "dev-table"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "pk"
  range_key    = "sk"
  
  point_in_time_recovery {
    enabled = true
  }

  attribute {
    name = "pk"
    type = "S"
  }

  attribute {
    name = "sk"
    type = "S"
  }

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}