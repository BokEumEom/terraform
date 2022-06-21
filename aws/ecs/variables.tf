variable "product_name" {
  type        = string
  description = "Product name"
  default     = "web"
}

variable "env_name" {
  description = "the name of your environment, e.g. \"prod\""
  type        = map(string)
  default = {
    "prod" = "prod"
    "stg"  = "staging"
    "test" = "test"
  }
}

variable "node_env" {
  description = "the name of your environment, e.g. \"prod\""
  type        = map(string)
  default = {
    "prod" = "product"
    "stg"  = "staging"
    "test" = "development"
  }
}

variable "container_cpu" {
  description = "The number of cpu units used by the task"
  type        = map(string)
  default = {
    "prod" = "256"
    "stg"  = "256"
    "test" = "256"
  }
}

variable "container_memory" {
  description = "The amount (in MiB) of memory used by the task"
  type        = map(string)
  default = {
    "prod" = "512"
    "stg"  = "512"
    "test" = "512"
  }
}

variable "service_desired_count" {
  description = "Number of tasks running in parallel"
  type        = map(string)
  default = {
    "prod" = "1"
    "stg"  = "1"
    "test" = "1"
  }
}

variable "image_tag" {
  description = "The tag name of ecr repositories"
  type        = map(string)
  default = {
    "prod" = "dev-latest"
    "stg"  = "stg-latest"
    "test" = "test-latest"
  }
}

variable "retention_in_days" {
  description = "The retention days of cloudwatch logs"
  type        = map(string)
  default = {
    "prod" = "30"
    "stg"  = "30"
    "test" = "30"
  }
}