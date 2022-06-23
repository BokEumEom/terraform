# Build Infrastructure
### Prerequisites
To follow this tutorial you will need:
* The [Terraform CLI](https://learn.hashicorp.com/tutorials/terraform/install-cli) (0.14.9+) installed.
* The [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html) installed.
* [An AWS account](https://aws.amazon.com/free/).
* Your AWS credentials. You can [create a new Access Key on this page](https://console.aws.amazon.com/iam/home?#/security_credentials).

### Usage:
* Specify the AWS region to create resources into, using region variable.

* Specify the aws-cli profile for the account to create resources in, using profile variable.
    * The default location to view your aws-cli profiles is $HOME/.aws/credentials on Linux and macOS and %USERPROFILE%\.aws\credentials on Windows.
    * There are a number of other options for authenticating with the AWS Provider. These can be found here: https://registry.terraform.io/providers/hashicorp/aws/latest/docs. To implement other strategies, replace the profile property of the aws provider as appropriate.

```
# Initialize the directory
$ terraform init

# Terraform Workspace Create
$ terraform workspace new test

# Terraform Workspace Select
$ terraform workspace list
  default
* test

# Current Workspace
$ terraform workspace show
test

# Format and validate the configuration
$ terraform validate

# Create execution plan
$ terraform plan

# Create infrastructure
$ terraform apply

# Inspect state
$ terraform show
```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 4.10.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 4.10.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_autoscaling"></a> [autoscaling](#module\_autoscaling) | ../modules/ecs_appautoscaling | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_log_group.web](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_cloudwatch_log_subscription_filter.elasticsearch_logfilter](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_subscription_filter) | resource |
| [aws_ecr_lifecycle_policy.web](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_lifecycle_policy) | resource |
| [aws_ecr_repository.web](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_repository) | resource |
| [aws_ecs_cluster.cluster](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_cluster) | resource |
| [aws_ecs_cluster_capacity_providers.cluster](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_cluster_capacity_providers) | resource |
| [aws_ecs_service.web](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_service) | resource |
| [aws_ecs_task_definition.web](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_task_definition) | resource |
| [aws_iam_role_policy.password_policy_parameterstore](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_lambda_permission.allow_cloudwatch](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_permission) | resource |
| [aws_security_group.web_sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_service_discovery_private_dns_namespace.cloud_map](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/service_discovery_private_dns_namespace) | resource |
| [aws_service_discovery_service.web](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/service_discovery_service) | resource |
| [aws_ssm_parameter.database_password_parameter](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter) | resource |
| [aws_ssm_parameter.database_username_parameter](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter) | resource |
| [aws_availability_zones.available](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/availability_zones) | data source |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_role.AutoScaling_ECSService](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_role) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |
| [aws_secretsmanager_secret_version.creds](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/secretsmanager_secret_version) | data source |
| [aws_subnets.private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnets) | data source |
| [aws_subnets.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnets) | data source |
| [aws_vpc.vpc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_container_cpu"></a> [container\_cpu](#input\_container\_cpu) | The number of cpu units used by the task | `map(string)` | <pre>{<br>  "prod": "256",<br>  "stg": "256",<br>  "test": "256"<br>}</pre> | no |
| <a name="input_container_memory"></a> [container\_memory](#input\_container\_memory) | The amount (in MiB) of memory used by the task | `map(string)` | <pre>{<br>  "prod": "512",<br>  "stg": "512",<br>  "test": "512"<br>}</pre> | no |
| <a name="input_env_name"></a> [env\_name](#input\_env\_name) | the name of your environment, e.g. "prod" | `map(string)` | <pre>{<br>  "prod": "prod",<br>  "stg": "staging",<br>  "test": "test"<br>}</pre> | no |
| <a name="input_image_tag"></a> [image\_tag](#input\_image\_tag) | The tag name of ecr repositories | `map(string)` | <pre>{<br>  "prod": "dev-latest",<br>  "stg": "stg-latest",<br>  "test": "test-latest"<br>}</pre> | no |
| <a name="input_node_env"></a> [node\_env](#input\_node\_env) | the name of your environment, e.g. "prod" | `map(string)` | <pre>{<br>  "prod": "product",<br>  "stg": "staging",<br>  "test": "development"<br>}</pre> | no |
| <a name="input_product_name"></a> [product\_name](#input\_product\_name) | Product name | `string` | `"web"` | no |
| <a name="input_retention_in_days"></a> [retention\_in\_days](#input\_retention\_in\_days) | The retention days of cloudwatch logs | `map(string)` | <pre>{<br>  "prod": "30",<br>  "stg": "30",<br>  "test": "30"<br>}</pre> | no |
| <a name="input_service_desired_count"></a> [service\_desired\_count](#input\_service\_desired\_count) | Number of tasks running in parallel | `map(string)` | <pre>{<br>  "prod": "1",<br>  "stg": "1",<br>  "test": "1"<br>}</pre> | no |

## Outputs

No outputs.