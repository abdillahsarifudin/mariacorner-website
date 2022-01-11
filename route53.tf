data "aws_route53_zone" "mariascorner-public-hosted-zone" {
  name    = var.mariascorner-domain-name
  private_zone = false
}