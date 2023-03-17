variable "db_instance_id" {
  description = "The RDS instance id you want to monitor"
  type        = string
}

variable "alarm_name_prefix" {
  description = "Alarm name prefix, used in the naming of alarms created"
  type        = string
  default     = ""
}

variable "alarm_name_postfix" {
  description = "Alarm name suffix, used in the naming of alarms created"
  type        = string
  default     = ""
}

variable "alarm_name_env" {
  description = "Alarm name env, used in the naming of alarms created"
  type        = string
  default     = ""
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

########################################
# SNS-Related Variables
########################################
variable "create_sns_topic" {
  description = "If you don't want to create the SNS topic, set this to false.  It will use the sns_topic value directly"
  type        = bool
  default     = true
}

variable "sns_topic" {
  description = "SNS topic you want to specify. If leave empty, it will use a prefix and a timestampe appended"
  type        = string
  default     = ""
}

variable "sns_topic_prefix" {
  description = "SNS topic prefix, only used if you're creating an SNS topic"
  type        = string
  default     = ""
}

variable "sns_topic_postfix" {
  description = "SNS topic suffix, only used if you're creating an SNS topic"
  type        = string
  default     = ""
}

########################################
# Boolean flagging to disable specific alarms not interested in using
########################################
variable "burst_balance_too_low" {
  description = "Enable monitoring of burst_balance_too_low"
  type        = bool
  default     = false
}

variable "cpu_utilization_too_high" {
  description = "Enable monitoring of cpu_utilization_too_high"
  type        = bool
  default     = true
}

variable "cpu_credit_balance_too_low" {
  description = "Enable monitoring of cpu_credit_balance_too_low"
  type        = bool
  default     = false
}

variable "disk_queue_depth_too_high" {
  description = "Enable monitoring of disk_queue_depth_too_high"
  type        = bool
  default     = false
}

variable "freeable_memory_too_low" {
  description = "Enable monitoring of freeable_memory_too_low"
  type        = bool
  default     = true
}

variable "free_storage_space_too_low" {
  description = "Enable monitoring of free_storage_space_too_low"
  type        = bool
  default     = true
}

variable "swap_usage_too_high" {
  description = "Enable monitoring of swap_usage_too_high"
  type        = bool
  default     = true
}

variable "connection_count_anomalous" {
  description = "Enable monitoring of connection_count_anomalous"
  type        = bool
  default     = true
}

########################################
# Evaluation period time length (in seconds) for alarms
########################################
variable "alarm_burst_balance_too_low_period" {
  description = "The period of the minimum available nodes should the statistics be applied in seconds"
  type        = number
  default     = 300
}

variable "alarm_cpu_utilization_too_high_period" {
  description = "The period of the cluster status is in red should the statistics be applied in seconds"
  type        = number
  default     = 300
}

variable "alarm_cpu_credit_balance_too_low_period" {
  description = "The period of the cluster status is in yellow should the statistics be applied in seconds"
  type        = number
  default     = 300
}

variable "alarm_disk_queue_depth_too_high_period" {
  description = "The period of the per-node free storage is too low should the statistics be applied in seconds"
  type        = number
  default     = 300
}

variable "alarm_freeable_memory_too_low_period" {
  description = "The period of the total cluster free storage is too low should the statistics be applied in seconds"
  type        = number
  default     = 300
}

variable "alarm_free_storage_space_too_low_period" {
  description = "The period of the cluster index writes being blocked should the statistics be applied in seconds"
  type        = number
  default     = 300
}

variable "alarm_swap_usage_too_high_period" {
  description = "The period of the automated snapshot failure should the statistics be applied in seconds"
  type        = number
  default     = 300
}

########################################
# Alarm thresholds
########################################
variable "burst_balance_threshold" {
  description = "The minimum percent of General Purpose SSD (gp2) burst-bucket I/O credits available."
  type        = number
  default     = 20
}

variable "cpu_utilization_threshold" {
  description = "The maximum percentage of CPU utilization."
  type        = number
  default     = 80
}

variable "cpu_credit_balance_threshold" {
  description = "The minimum number of CPU credits (t2 instances only) available."
  type        = number
  default     = 20
}

variable "disk_queue_depth_threshold" {
  description = "The maximum number of outstanding IOs (read/write requests) waiting to access the disk."
  type        = number
  default     = 64
}

variable "freeable_memory_threshold" {
  description = "The minimum amount of available random access memory in Byte."
  type        = number
  default     = 64000000

  # 64 Megabyte in Byte
}

variable "free_storage_space_threshold" {
  description = "The minimum amount of available storage space in Byte."
  type        = number
  default     = 2000000000

  # 2 Gigabyte in Byte
}

variable "swap_usage_threshold" {
  description = "The maximum amount of swap space used on the DB instance in Byte."
  type        = number
  default     = 256000000

  # 256 Megabyte in Byte
}

########################################
# Evaluation periods for alarms
########################################
variable "alarm_burst_balance_too_low_periods" {
  description = "The number of periods to alert that cluster status is red.  Default: 1, raise this to be less noisy, as this can occur often for only 1 period"
  type        = number
  default     = 1
}

variable "alarm_cpu_utilization_too_high_periods" {
  description = "The number of periods to alert that cluster status is yellow.  Default: 1, raise this to be less noisy, as this can occur often for only 1 period"
  type        = number
  default     = 1
}

variable "alarm_cpu_credit_balance_too_low_periods" {
  description = "The number of periods to alert that the per-node free storage space is too low.  Default: 1, raise this to be less noisy, as this can occur often for only 1 period"
  type        = number
  default     = 1
}

variable "alarm_disk_queue_depth_too_high_periods" {
  description = "The number of periods to alert that total cluster free storage space is too low.  Default: 1, raise this to be less noisy, as this can occur often for only 1 period"
  type        = number
  default     = 1
}

variable "alarm_freeable_memory_too_low_periods" {
  description = "The number of periods to alert that cluster index writes are blocked.  Default: 1, raise this to be less noisy, as this can occur often for only 1 period"
  type        = number
  default     = 1
}

variable "alarm_free_storage_space_too_low_periods" {
  description = "The number of periods to alert that minimum number of available nodes dropped below a threshold.  Default: 1, raise this to be less noisy, as this can occur often for only 1 period"
  type        = number
  default     = 1
}

variable "alarm_swap_usage_too_high_periods" {
  description = "The number of periods to alert that minimum number of available nodes dropped below a threshold.  Default: 1, raise this to be less noisy, as this can occur often for only 1 period"
  type        = number
  default     = 1
}

variable "alarm_connection_count_anomalous_periods" {
  description = "The number of periods to alert that minimum number of available nodes dropped below a threshold.  Default: 1, raise this to be less noisy, as this can occur often for only 1 period"
  type        = number
  default     = 5
}