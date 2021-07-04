data "aws_caller_identity" "self" {}

data "aws_region" "current" {}

data "aws_ecs_cluster" "this" {
  cluster_name = "${local.name_prefix}-${local.service_name}"
}

data "aws_ecs_service" "this" {
  cluster_arn  = "${local.name_prefix}-${local.service_name}"
  service_name = "${local.name_prefix}-${local.service_name}"
}

data "aws_s3_bucket" "env_file" {
  bucket = "shonansurvivors-${local.name_prefix}-${local.service_name}-env-file"
}
