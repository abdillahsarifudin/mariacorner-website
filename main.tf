resource "aws_s3_bucket" "mariacorner-s3-bucket" {
  bucket = var.s3-bucket-name
  acl    = "public-read"

  policy = <<EOF
{
     "id" : "MakePublic",
   "version" : "2012-10-17",
   "statement" : [
      {
         "action" : [
             "s3:GetObject"
          ],
         "effect" : "Allow",
         "resource" : "arn:aws:s3:::${var.s3-bucket-name}/*",
         "principal" : "*"
      }
    ]
  }
EOF

  website {
    index_document = "index.html"
  }
}