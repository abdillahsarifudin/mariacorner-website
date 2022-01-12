data "aws_route53_zone" "mariascorner-public-hosted-zone" {
  name         = var.mariascorner-domain-name
  private_zone = false
}

resource "aws_route53_record" "mariascorner-cloudfront-dns-record" {
  zone_id = data.aws_route53_zone.mariascorner-public-hosted-zone.zone_id
  name    = "mariascorner.co"
  type    = "A"
  alias {
    name                   = aws_cloudfront_distribution.mariascorner-website-distribution.domain_name
    zone_id                = aws_cloudfront_distribution.mariascorner-website-distribution.hosted_zone_id
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "mariascorner-subdomain-cloudfront-dns-record" {
  zone_id = data.aws_route53_zone.mariascorner-public-hosted-zone.zone_id
  name    = "www.mariascorner.co"
  type    = "A"
  alias {
    name                   = aws_cloudfront_distribution.mariascorner-website-distribution.domain_name
    zone_id                = aws_cloudfront_distribution.mariascorner-website-distribution.hosted_zone_id
    evaluate_target_health = true
  }
}