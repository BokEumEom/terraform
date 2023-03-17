variable "instance_id" {
  description = "The EC2 instance id you want to monitor"
  type        = string
}

variable "image_id" {
  description = "The EC2 image id you want to monitor"
  type        = string
}

variable "instance_type" {
  description = "The EC2 instance type you want to monitor"
  type        = string
}

variable "device" {
  description = "The EC2 instance disk device you want to monitor"
  type        = string
}

variable "mount_path" {
  description = "The EC2 instance disk mount path you want to monitor"
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

variable "alarm_name_path" {
  description = "Alarm name mount path, used in the naming of alarms created"
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
variable "monitor_status_check_failed" {
  description = "Enable monitoring of burst_balance_too_low"
  type        = bool
  default     = true
}

variable "monitor_cpu_utilization_too_high" {
  description = "Enable monitoring of cpu_utilization_too_high"
  type        = bool
  default     = true
}

variable "monitor_mem_utilization_too_high" {
  description = "Enable monitoring of cpu_credit_balance_too_low"
  type        = bool
  default     = true
}

variable "monitor_disk_usage_too_high" {
  description = "Enable monitoring of disk_queue_depth_too_high"
  type        = bool
  default     = true
}

variable "monitor_disk_usage_too_high_windows" {
  description = "Enable monitoring of disk_queue_depth_too_high"
  type        = bool
  default     = true
}

########################################
# Evaluation period time length (in seconds) for alarms
########################################
variable "alarm_status_check_failed_period" {
  description = "The period of the ec2 instance status check failed"
  type        = number
  default     = 60
}

variable "alarm_cpu_utilization_too_high_period" {
  description = "The period of the CPU utilization is too high should the statistics be applied in seconds"
  type        = number
  default     = 60
}

variable "alarm_mem_utilization_too_high_period" {
  description = "The period of the Memory utilization is too high should the statistics be applied in seconds"
  type        = number
  default     = 60
}

variable "alarm_disk_usage_too_high_period" {
  description = "The period of the Disk usage is too high should the statistics be applied in seconds"
  type        = number
  default     = 60
}

########################################
# Alarm thresholds
########################################
variable "status_check_failed_threshold" {
  description = "The minimum percent of General Purpose SSD (gp2) burst-bucket I/O credits available."
  type        = number
  default     = 1
}

variable "cpu_utilization_threshold" {
  description = "The maximum percentage of CPU utilization."
  type        = number
  default     = 75
}

variable "mem_utilization_threshold" {
  description = "The maximum percentage of Memory utilization."
  type        = number
  default     = 75
}

variable "disk_usage_threshold" {
  description = "The maximum percentage of Disk usage."
  type        = number
  default     = 75
}

########################################
# Evaluation periods for alarms
########################################
variable "alarm_status_check_failed_periods" {
  description = "The number of periods to alert that cluster status is red.  Default: 1, raise this to be less noisy, as this can occur often for only 1 period"
  type        = number
  default     = 1
}

variable "alarm_cpu_utilization_too_high_periods" {
  description = "The number of periods to alert that cluster status is yellow.  Default: 1, raise this to be less noisy, as this can occur often for only 1 period"
  type        = number
  default     = 3
}

variable "alarm_mem_utilization_too_high_periods" {
  description = "The number of periods to alert that the per-node free storage space is too low.  Default: 1, raise this to be less noisy, as this can occur often for only 1 period"
  type        = number
  default     = 3
}

variable "alarm_disk_usage_too_high_periods" {
  description = "The number of periods to alert that total cluster free storage space is too low.  Default: 1, raise this to be less noisy, as this can occur often for only 1 period"
  type        = number
  default     = 3
}