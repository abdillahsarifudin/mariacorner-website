locals {
  s3_origin_id = module.s3-bucket-mariacorner-website.s3_bucket_bucket_regional_domain_name
}

resource "aws_cloudfront_origin_access_identity" "mariascorner-website-oai" {
  comment = "OAI for the Maria's Corner Marketing Website"
}

resource "aws_cloudfront_distribution" "mariascorner-website-distribution" {
  origin {
    domain_name = module.s3-bucket-mariacorner-website.s3_bucket_bucket_regional_domain_name
    origin_id   = local.s3_origin_id

    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.mariascorner-website-oai.cloudfront_access_identity_path
    }
  }

  aliases             = ["www.${data.aws_route53_zone.mariascorner-public-hosted-zone.name}", "${data.aws_route53_zone.mariascorner-public-hosted-zone.name}"]
  enabled             = true
  is_ipv6_enabled     = true
  price_class         = "PriceClass_All"
  retain_on_delete    = false
  wait_for_deployment = false
  default_root_object = "index.html"

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  default_cache_behavior {
    target_origin_id       = local.s3_origin_id
    viewer_protocol_policy = "redirect-to-https"

    allowed_methods = ["GET", "HEAD", "OPTIONS"]
    cached_methods  = ["GET", "HEAD"]
    compress        = true

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }
    min_ttl     = 0
    default_ttl = 3600
    max_ttl     = 86400
  }

  viewer_certificate {
    acm_certificate_arn            = data.aws_acm_certificate.mariascorner-issued-ssl-certificate-us-east-1.arn
    minimum_protocol_version       = "TLSv1.2_2021"
    ssl_support_method             = "sni-only"
    cloudfront_default_certificate = false
  }

  depends_on = [module.s3-bucket-mariacorner-website]
}