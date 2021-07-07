resource "aws_acm_certificate" "root" {
  domain_name = data.aws_route53_zone.this.name

  validation_method = "DNS"

  tags = {
    Name = "${local.name_prefix}-appfoobar-link"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_acm_certificate_validation" "root" {
  certificate_arn = aws_acm_certificate.root.arn
}

resource "aws_acm_certificate" "root_cdn" {
  provider = aws.virginia

  domain_name = data.aws_route53_zone.this.name

  validation_method = "DNS"

  tags = {
    Name = "${local.name_prefix}-appfoobar-link"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_acm_certificate_validation" "root_cdn" {
  provider = aws.virginia

  certificate_arn = aws_acm_certificate.root_cdn.arn
}
