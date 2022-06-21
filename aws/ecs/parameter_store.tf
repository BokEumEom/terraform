resource "aws_ssm_parameter" "database_password_parameter" {
  name        = "/${var.env_name[terraform.workspace]}/database/password/master"
  description = "Test environment database password"
  type        = "SecureString"
  value       = local.db_creds.password
}

resource "aws_ssm_parameter" "database_username_parameter" {
  name        = "/${var.env_name[terraform.workspace]}/database/username/master"
  description = "Test environment database username"
  type        = "SecureString"
  value       = local.db_creds.username
}

resource "aws_iam_role_policy" "password_policy_parameterstore" {
  name = "password-policy-parameterstore"
  role = "ecsTaskExecutionRole"

  policy = <<-EOF
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Action": [
          "ssm:GetParameters",
          "kms:Decrypt"
        ],
        "Effect": "Allow",
        "Resource": [
          "${aws_ssm_parameter.database_password_parameter.arn}",
          "${aws_ssm_parameter.database_username_parameter.arn}"
        ]
      }
    ]
  }
  EOF
}

