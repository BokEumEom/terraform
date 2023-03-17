# terraform-aws-ec2-cloudwatch-sns-alarms
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 2.7 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 2.7 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_metric_alarm.cpu_utilization_too_high](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_cloudwatch_metric_alarm.disk_usage_too_high](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_cloudwatch_metric_alarm.mem_utilization_too_high](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_cloudwatch_metric_alarm.status_check_failed](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_sns_topic.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic) | resource |
| [aws_sns_topic.default_prefix](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic) | resource |
| [aws_sns_topic_policy.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic_policy) | resource |
| [aws_caller_identity.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.sns_topic_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_alarm_cpu_utilization_too_high_period"></a> [alarm\_cpu\_utilization\_too\_high\_period](#input\_alarm\_cpu\_utilization\_too\_high\_period) | The period of the CPU utilization is too high should the statistics be applied in seconds | `number` | `60` | no |
| <a name="input_alarm_cpu_utilization_too_high_periods"></a> [alarm\_cpu\_utilization\_too\_high\_periods](#input\_alarm\_cpu\_utilization\_too\_high\_periods) | The number of periods to alert that cluster status is yellow.  Default: 1, raise this to be less noisy, as this can occur often for only 1 period | `number` | `3` | no |
| <a name="input_alarm_disk_usage_too_high_period"></a> [alarm\_disk\_usage\_too\_high\_period](#input\_alarm\_disk\_usage\_too\_high\_period) | The period of the Disk usage is too high should the statistics be applied in seconds | `number` | `60` | no |
| <a name="input_alarm_disk_usage_too_high_periods"></a> [alarm\_disk\_usage\_too\_high\_periods](#input\_alarm\_disk\_usage\_too\_high\_periods) | The number of periods to alert that total cluster free storage space is too low.  Default: 1, raise this to be less noisy, as this can occur often for only 1 period | `number` | `3` | no |
| <a name="input_alarm_mem_utilization_too_high_period"></a> [alarm\_mem\_utilization\_too\_high\_period](#input\_alarm\_mem\_utilization\_too\_high\_period) | The period of the Memory utilization is too high should the statistics be applied in seconds | `number` | `60` | no |
| <a name="input_alarm_mem_utilization_too_high_periods"></a> [alarm\_mem\_utilization\_too\_high\_periods](#input\_alarm\_mem\_utilization\_too\_high\_periods) | The number of periods to alert that the per-node free storage space is too low.  Default: 1, raise this to be less noisy, as this can occur often for only 1 period | `number` | `3` | no |
| <a name="input_alarm_name_env"></a> [alarm\_name\_env](#input\_alarm\_name\_env) | Alarm name env, used in the naming of alarms created | `string` | `""` | no |
| <a name="input_alarm_name_postfix"></a> [alarm\_name\_postfix](#input\_alarm\_name\_postfix) | Alarm name suffix, used in the naming of alarms created | `string` | `""` | no |
| <a name="input_alarm_name_prefix"></a> [alarm\_name\_prefix](#input\_alarm\_name\_prefix) | Alarm name prefix, used in the naming of alarms created | `string` | `""` | no |
| <a name="input_alarm_status_check_failed_period"></a> [alarm\_status\_check\_failed\_period](#input\_alarm\_status\_check\_failed\_period) | The period of the ec2 instance status check failed | `number` | `60` | no |
| <a name="input_alarm_status_check_failed_periods"></a> [alarm\_status\_check\_failed\_periods](#input\_alarm\_status\_check\_failed\_periods) | The number of periods to alert that cluster status is red.  Default: 1, raise this to be less noisy, as this can occur often for only 1 period | `number` | `1` | no |
| <a name="input_cpu_utilization_threshold"></a> [cpu\_utilization\_threshold](#input\_cpu\_utilization\_threshold) | The maximum percentage of CPU utilization. | `number` | `75` | no |
| <a name="input_create_sns_topic"></a> [create\_sns\_topic](#input\_create\_sns\_topic) | If you don't want to create the SNS topic, set this to false.  It will use the sns\_topic value directly | `bool` | `true` | no |
| <a name="input_device"></a> [device](#input\_device) | The RDS instance id you want to monitor | `string` | n/a | yes |
| <a name="input_disk_usage_threshold"></a> [disk\_usage\_threshold](#input\_disk\_usage\_threshold) | The maximum percentage of Disk usage. | `number` | `75` | no |
| <a name="input_fstype"></a> [fstype](#input\_fstype) | The RDS instance id you want to monitor | `string` | n/a | yes |
| <a name="input_image_id"></a> [image\_id](#input\_image\_id) | The RDS instance id you want to monitor | `string` | n/a | yes |
| <a name="input_instance_id"></a> [instance\_id](#input\_instance\_id) | The RDS instance id you want to monitor | `string` | n/a | yes |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | The RDS instance id you want to monitor | `string` | n/a | yes |
| <a name="input_mem_utilization_threshold"></a> [mem\_utilization\_threshold](#input\_mem\_utilization\_threshold) | The maximum percentage of Memory utilization. | `number` | `75` | no |
| <a name="input_monitor_cpu_utilization_too_high"></a> [monitor\_cpu\_utilization\_too\_high](#input\_monitor\_cpu\_utilization\_too\_high) | Enable monitoring of cpu\_utilization\_too\_high | `bool` | `true` | no |
| <a name="input_monitor_disk_usage_too_high"></a> [monitor\_disk\_usage\_too\_high](#input\_monitor\_disk\_usage\_too\_high) | Enable monitoring of disk\_queue\_depth\_too\_high | `bool` | `true` | no |
| <a name="input_monitor_mem_utilization_too_high"></a> [monitor\_mem\_utilization\_too\_high](#input\_monitor\_mem\_utilization\_too\_high) | Enable monitoring of cpu\_credit\_balance\_too\_low | `bool` | `true` | no |
| <a name="input_monitor_status_check_failed"></a> [monitor\_status\_check\_failed](#input\_monitor\_status\_check\_failed) | Enable monitoring of burst\_balance\_too\_low | `bool` | `true` | no |
| <a name="input_mount_path"></a> [mount\_path](#input\_mount\_path) | The RDS instance id you want to monitor | `string` | n/a | yes |
| <a name="input_sns_topic"></a> [sns\_topic](#input\_sns\_topic) | SNS topic you want to specify. If leave empty, it will use a prefix and a timestampe appended | `string` | `""` | no |
| <a name="input_sns_topic_postfix"></a> [sns\_topic\_postfix](#input\_sns\_topic\_postfix) | SNS topic suffix, only used if you're creating an SNS topic | `string` | `""` | no |
| <a name="input_sns_topic_prefix"></a> [sns\_topic\_prefix](#input\_sns\_topic\_prefix) | SNS topic prefix, only used if you're creating an SNS topic | `string` | `""` | no |
| <a name="input_status_check_failed_threshold"></a> [status\_check\_failed\_threshold](#input\_status\_check\_failed\_threshold) | The minimum percent of General Purpose SSD (gp2) burst-bucket I/O credits available. | `number` | `1` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to all resources | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_sns_topic_arn"></a> [sns\_topic\_arn](#output\_sns\_topic\_arn) | The ARN of the SNS topic |
| <a name="output_sns_topic_name"></a> [sns\_topic\_name](#output\_sns\_topic\_name) | The SNS topic name |