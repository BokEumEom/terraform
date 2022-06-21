################################################################################
# CloudWatch Logs Subscription
################################################################################
locals {
  log_group_name = toset([
    "${aws_cloudwatch_log_group.web_server1.name}",
    "${aws_cloudwatch_log_group.web_server2.name}",
    "${aws_cloudwatch_log_group.web_server3.name}",
    "${aws_cloudwatch_log_group.web_server4.name}",
    "${aws_cloudwatch_log_group.web_server5.name}",
    "${aws_cloudwatch_log_group.web_server6.name}",
    "${aws_cloudwatch_log_group.web_server7.name}",
    "${aws_cloudwatch_log_group.web_server8.name}",
    "${aws_cloudwatch_log_group.web_server9.name}",
    "${aws_cloudwatch_log_group.web_server10.name}"
  ])
}

locals {
  log_group_arn = toset([
    "${aws_cloudwatch_log_group.web_server1.arn}",
    "${aws_cloudwatch_log_group.web_server2.arn}",
    "${aws_cloudwatch_log_group.web_server3.arn}",
    "${aws_cloudwatch_log_group.web_server4.arn}",
    "${aws_cloudwatch_log_group.web_server5.arn}",
    "${aws_cloudwatch_log_group.web_server6.arn}",
    "${aws_cloudwatch_log_group.web_server7.arn}",
    "${aws_cloudwatch_log_group.web_server8.arn}",
    "${aws_cloudwatch_log_group.web_server9.arn}",
    "${aws_cloudwatch_log_group.web_server10.arn}"
  ])
}

resource "aws_cloudwatch_log_subscription_filter" "elasticsearch_logfilter" {
  for_each        = local.log_group_name
  name            = each.key
  log_group_name  = each.key
  filter_pattern  = ""
  destination_arn = var.lambda_funtion_arn
}

resource "aws_lambda_permission" "allow_cloudwatch" {
  for_each      = local.log_group_arn
  action        = "lambda:InvokeFunction"
  function_name = "LogsToElasticsearch_es-dev-cluster"
  principal     = "logs.${data.aws_region.current.name}.amazonaws.com"
  source_arn    = format("%s:*", each.key)
}