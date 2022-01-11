module "s3-bucket-mariacorner-website" {
  source        = "terraform-aws-modules/s3-bucket/aws"
  version       = "2.11.2"
  bucket        = var.mariascorner-s3-bucket-name
  acl           = "public-read"
  attach_policy = true
  force_destroy = true

  policy = data.aws_iam_policy_document.public-read-bucket-policy.json

  website = {
    index_document = "index.html"
    error_document = "error.html"
  }

  server_side_encryption_configuration = {
    rule = {
      apply_server_side_encryption_by_default = {
        sse_algorithm = "AES256"
      }
    }
  }

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false

  tags = merge(
    var.additional_tags,
    {
      Name = var.mariascorner-s3-bucket-name
    },
  )
}

data "aws_iam_policy_document" "public-read-bucket-policy" {
  statement {
    sid       = "Allow Public Read"
    actions   = ["s3:GetObject"]
    resources = ["${module.s3-bucket-mariacorner-website.s3_bucket_arn}/*", ]

    principals {
      type        = "*"
      identifiers = ["*"]
    }
  }
}