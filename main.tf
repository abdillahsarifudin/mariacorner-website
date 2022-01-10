resource "aws_s3_bucket" "mariacorner-s3-bucket" {
  bucket = var.s3-bucket-name
  acl    = "public-read"
  policy = data.aws_iam_policy_document.public-read-bucket-policy.json

  website {
    index_document = "index.html"
    error_document = "error.html"
  }
}

data "aws_iam_policy_document" "public-read-bucket-policy" {
  statement {
    sid       = "Allow Public Read"
    actions   = ["s3:GetObject"]
    resources = ["arn:aws:s3:::${var.s3-bucket-name}", ]

    principals {
      type        = "*"
      identifiers = ["*"]
    }
  }
}