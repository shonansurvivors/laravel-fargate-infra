resource "aws_route53_zone" "this" {
  name = "foobar.internal"

  vpc {
    vpc_id = data.terraform_remote_state.network_main.outputs.vpc_this_id
  }
}

resource "aws_route53_record" "db_cname" {
  zone_id = aws_route53_zone.this.zone_id
  name    = "db.${aws_route53_zone.this.name}"
  type    = "CNAME"
  ttl     = 300

  records = [
    data.terraform_remote_state.db_foobar.outputs.db_instance_this_address
  ]
}

resource "aws_route53_record" "cache_cname" {
  zone_id = aws_route53_zone.this.zone_id
  name    = "cache.${aws_route53_zone.this.name}"
  type    = "CNAME"
  ttl     = 300

  records = [
    data.terraform_remote_state.cache_foobar.outputs.elasticache_replication_group_this_primary_endpoint_address
  ]
}
