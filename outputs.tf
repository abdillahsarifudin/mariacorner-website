output "s3_bucket_website_endpoint" {
  value = module.s3-bucket-mariacorner-website.s3_bucket_website_endpoint
}

output "s3_bucket_arn" {
  value = module.s3-bucket-mariacorner-website.s3_bucket_arn
}

output "s3_bucket_regional_domain_name" {
  value = module.s3-bucket-mariacorner-website.s3_bucket_bucket_regional_domain_name
}

output "cloudfront_distribution_domain_name" {
  value = aws_cloudfront_distribution.mariascorner-website-distribution.domain_name
}

output "cloudfront_distribution_hosted_zone_id" {
  value = aws_cloudfront_distribution.mariascorner-website-distribution.hosted_zone_id
}

output "cloudfront_origin_access_identity_iam_arn" {
  value = aws_cloudfront_origin_access_identity.mariascorner-website-oai.iam_arn
}