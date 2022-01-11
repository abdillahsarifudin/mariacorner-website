module "mariascorner-acm-ap-southeast-1" {
  source  = "terraform-aws-modules/acm/aws"
  version = "~> 3.0"

  domain_name = data.aws_route53_zone.mariascorner-public-hosted-zone.name
  zone_id     = data.aws_route53_zone.mariascorner-public-hosted-zone.zone_id

  subject_alternative_names = ["*.${data.aws_route53_zone.mariascorner-public-hosted-zone.name}", ]

  wait_for_validation = false

  tags = {
    Name = data.aws_route53_zone.mariascorner-public-hosted-zone.name
  }
}

resource "aws_acm_certificate" "mariascorner-ssl-certificate-us-east-1" {
  provider                  = aws.acm-provider
  domain_name               = var.mariascorner-domain-name
  subject_alternative_names = ["*.${data.aws_route53_zone.mariascorner-public-hosted-zone.name}", ]
  validation_method         = "DNS"
}

resource "aws_route53_record" "mariascorner-ssl-validation-dns-record-us-east-1" {
  for_each = {
    for dvo in aws_acm_certificate.mariascorner-ssl-certificate-us-east-1.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = data.aws_route53_zone.mariascorner-public-hosted-zone.zone_id
}

resource "aws_acm_certificate_validation" "mariascorner-ssl-certificate-validation-us-east-1" {
  provider                = aws.acm-provider
  certificate_arn         = aws_acm_certificate.mariascorner-ssl-certificate-us-east-1.arn
  validation_record_fqdns = [for record in aws_route53_record.mariascorner-ssl-validation-dns-record-us-east-1 : record.fqdn]
}