data "aws_ecs_service" "this" {
  cluster_arn  = "${local.name_prefix}-${local.service_name}"
  service_name = "${local.name_prefix}-${local.service_name}"
}
