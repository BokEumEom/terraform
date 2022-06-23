
resource "aws_elasticache_cluster" "redis" {
  cluster_id           = "${var.product_name}-${var.env_name[terraform.workspace]}-redis-cluster"
  engine               = "redis"
  node_type            = var.redis_node_type[terraform.workspace]
  num_cache_nodes      = var.redis_num_cache_nodes[terraform.workspace]
  parameter_group_name = "default.redis6.x"
  engine_version       = "6.x"
  port                 = "6379"
  subnet_group_name    = aws_elasticache_subnet_group.redis-sub-gp.name
  security_group_ids   = [aws_security_group.redis-cluster-sg.id]

  tags = {
    Terraform   = "true"
    Environment = "${var.env_name[terraform.workspace]}"
  }
}

resource "aws_elasticache_subnet_group" "redis-sub-gp" {
  description = "${var.product_name} ${var.env_name[terraform.workspace]} redis subnet group"
  name        = "${var.product_name}-${var.env_name[terraform.workspace]}-redis-sub-gp"
  subnet_ids  = data.aws_subnet_ids.private.ids

  tags = {
    Terraform   = "true"
    Environment = "${var.env_name[terraform.workspace]}"
  }
}
# resource "aws_elasticache_cluster" "redis-dev" {
#   availability_zone    = "ap-northeast-2c"
#   cluster_id           = "dev-001"
#   replication_group_id = "${aws_elasticache_replication_group.redis-dev.replication_group_id}"
# }

# Read Replica Instance
# resource "aws_elasticache_replication_group" "redis-dev" {
#   at_rest_encryption_enabled = "false"
#   auto_minor_version_upgrade = "true"
#   automatic_failover_enabled = "false"

#   engine                        = "redis"
#   engine_version                = "6.x"
#   maintenance_window            = "thu:09:00-thu:10:00"
#   multi_az_enabled              = "false"
#   node_type                     = "cache.t4g.micro"
#   number_cache_clusters         = "1"
#   parameter_group_name          = "default.redis6.x"
#   port                          = "6379"
#   replication_group_description = "redis-dev"
#   replication_group_id          = "-redis-dev"
#   security_group_ids            = "${aws_security_group.redis-dev-sg.id}""
#   snapshot_retention_limit      = "0"
#   snapshot_window               = "23:00-00:00"
#   subnet_group_name             = "${aws_elasticache_subnet_group.redis-dev-subnet-group.name}"
#   transit_encryption_enabled    = "false"
# }