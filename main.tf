resource "aws_s3_bucket" "mariacorner-s3-bucket" {
    bucket = var.s3-bucket.name
    acl = "public-read"

    policy  = <<EOF
{
     "Id" : "MakePublic",
   "Version" : "2012-10-17",
   "Statement" : [
      {
         "Action" : [
             "s3:GetObject"
          ],
         "Effect" : "Allow",
         "Resource" : "arn:aws:s3:::"${var.s3-bucket.name}"/*",
         "Principal" : "*"
      }
    ]
  }
EOF
website {
       index_document = "index.html"
   }
}