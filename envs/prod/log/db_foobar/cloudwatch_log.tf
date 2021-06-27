resource "aws_cloudwatch_log_group" "error" {
  name = "/aws/rds/instance/${local.name_prefix}-${local.service_name}/error"

  retention_in_days = 90
}

resource "aws_cloudwatch_log_group" "general" {
  name = "/aws/rds/instance/${local.name_prefix}-${local.service_name}/general"

  retention_in_days = 90
}

resource "aws_cloudwatch_log_group" "slowquery" {
  name = "/aws/rds/instance/${local.name_prefix}-${local.service_name}/slowquery"

  retention_in_days = 90
}
