locals {
  s3_origin_id = var.mariascorner-s3-bucket-name
}

module "mariascorner-website-cloudfront" {
  source  = "terraform-aws-modules/cloudfront/aws"
  version = "2.9.1"

  aliases             = ["www.${data.aws_route53_zone.mariascorner-public-hosted-zone.name}"]
  enabled             = true
  is_ipv6_enabled     = true
  price_class         = "PriceClass_All"
  retain_on_delete    = false
  wait_for_deployment = false
  default_root_object = "index.html"

  create_origin_access_identity = true
  origin_access_identities = {
    "${var.mariascorner-s3-bucket-name}-oai" = "OAI for the Maria's Corner Marketing Website"
  }

  origin = {
    (local.s3_origin_id) = {
      domain_name = module.s3-bucket-mariacorner-website.s3_bucket_bucket_regional_domain_name
      s3_origin_config = {
        origin_access_identity = "${var.mariascorner-s3-bucket-name}-oai"
      }
    }
  }

  custom_error_response = [
    {
      "error_caching_min_ttl" = 300,
      "error_code"            = 404
      "response_code"         = 404,
      "response_page_path"    = "/error.html"

    },
    {
      "error_caching_min_ttl" = 300,
      "error_code"            = 403
      "response_code"         = 403,
      "response_page_path"    = "/error.html"
    }
  ]

  default_cache_behavior = {
    target_origin_id       = local.s3_origin_id
    viewer_protocol_policy = "redirect-to-https"

    allowed_methods = ["GET", "HEAD", "OPTIONS"]
    cached_methods  = ["GET", "HEAD"]
    compress        = true
    query_string    = true
  }

  viewer_certificate = {
    acm_certificate_arn = data.aws_acm_certificate.mariascorner-issued-ssl-certificate-us-east-1.arn
    ssl_support_method  = "sni-only"
  }

  depends_on = [module.s3-bucket-mariacorner-website]
}