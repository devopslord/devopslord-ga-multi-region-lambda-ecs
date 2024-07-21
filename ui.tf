
##################################################
# Frontend Primary Region
##################################################

resource "aws_s3_bucket" "primary-frontend-bucket" {
  bucket = "frontend-bucket-primary-${random_string.this.result}"
}

resource "aws_s3_bucket_ownership_controls" "example-primary" {
  bucket = aws_s3_bucket.primary-frontend-bucket.id



  rule {
    object_ownership = "ObjectWriter"
  }
}

resource "aws_s3_bucket_policy" "allow_access_from_another_account" {
  bucket = aws_s3_bucket.primary-frontend-bucket.id

  depends_on = [ aws_s3_bucket_ownership_controls.example-primary ]
  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "PublicReadGetObject",
            "Effect": "Allow",
            "Principal": "*",
            "Action": "s3:GetObject",
            "Resource": "${aws_s3_bucket.primary-frontend-bucket.arn}/*"
        }
    ]
}

EOF
}

resource "aws_s3_bucket_public_access_block" "example-primary" {
  bucket = aws_s3_bucket.primary-frontend-bucket.id

  block_public_acls   = false
  block_public_policy = false
}

resource "aws_s3_object" "build-primary" {
  for_each = fileset("./src/dashboard/", "**")
  bucket = aws_s3_bucket.primary-frontend-bucket.id
  key = each.value
  source = "./src/dashboard/${each.value}"
  etag = filemd5("./src/dashboard/${each.value}")
  acl    = "public-read"
content_type = lookup(local.mime_types, regex("\\.[^.]+$", each.key), null)

depends_on = [ aws_s3_bucket_ownership_controls.example-primary ]
}

resource "aws_s3_bucket_website_configuration" "config-primary" {
  bucket = aws_s3_bucket.primary-frontend-bucket.id
  index_document {
    suffix = "index.html"
  }
}

locals {
    mime_types = {
      ".html" = "text/html"
      ".png"  = "image/png"
      ".jpg"  = "image/jpeg"
      ".gif"  = "image/gif"
      ".css"  = "text/css"
      ".js"   = "application/javascript"
    }
}


##################################################
# Frontend Failover Region
##################################################

resource "aws_s3_bucket" "secondary-frontend-bucket" {
  bucket = "frontend-bucket-secondary-${random_string.this.result}"

  provider = aws.region2
}



resource "aws_s3_bucket_ownership_controls" "example-secondary" {
  bucket = aws_s3_bucket.secondary-frontend-bucket.id

  rule {
    object_ownership = "ObjectWriter"
  }
  provider = aws.region2
}




resource "aws_s3_bucket_public_access_block" "example-secondary" {
  bucket = aws_s3_bucket.secondary-frontend-bucket.id

  block_public_acls   = false
  block_public_policy = false

  provider = aws.region2
}

resource "aws_s3_bucket_policy" "allow_access_from_another_account2" {
  bucket = aws_s3_bucket.secondary-frontend-bucket.id
  provider = aws.region2
  depends_on = [ aws_s3_bucket_ownership_controls.example-secondary ]

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "PublicReadGetObject",
            "Effect": "Allow",
            "Principal": "*",
            "Action": "s3:GetObject",
            "Resource": "${aws_s3_bucket.secondary-frontend-bucket.arn}/*"
        }
    ]
}

EOF
}

resource "aws_s3_object" "build-secondary" {
  for_each = fileset("./src/dashboard/", "**")
  bucket = aws_s3_bucket.secondary-frontend-bucket.id
  key = each.value
  source = "./src/dashboard/${each.value}"
  etag = filemd5("./src/dashboard/${each.value}")
  acl    = "public-read"
content_type = lookup(local.mime_types, regex("\\.[^.]+$", each.key), null)

depends_on = [ aws_s3_bucket_ownership_controls.example-secondary ]

    provider = aws.region2
}

resource "aws_s3_bucket_website_configuration" "config-secondary" {
  bucket = aws_s3_bucket.secondary-frontend-bucket.id
  index_document {
    suffix = "index.html"
  }

  provider = aws.region2
}
