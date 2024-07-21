resource "aws_route53_record" "api" {
  zone_id = var.zone_id
  name    = "${var.domain_name}"
  type    = "A"

  alias {
    evaluate_target_health = false
    name                   = module.global_accelerator.dns_name
    zone_id                = module.global_accelerator.hosted_zone_id
  }

}

resource "aws_route53_record" "ui" {
  zone_id = var.zone_id
  name    = "${var.trainsaction_domain}"
  type    = "A"

  alias {
    evaluate_target_health = false
    name                   = aws_cloudfront_distribution.this.domain_name
    zone_id                = aws_cloudfront_distribution.this.hosted_zone_id
  }

}