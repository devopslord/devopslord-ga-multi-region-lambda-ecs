locals {
  public_bucket_name = "t360-photos-bucket-public-${random_string.this.result}"
  private_bucket_name = "t360-photos-bucket-private-${random_string.this.result}"
  private_bucket_replica = "t360-photos-bucket-private-replica-${random_string.this.result}"

}

resource "aws_kms_key" "replica" {
  provider = aws.region2

  description             = "S3 bucket replication KMS key"
  deletion_window_in_days = 7
}

resource "random_string" "this" {
  length           = 7
  special          = false
  upper            = false 
}

module "s3_bucket" {
  source = "terraform-aws-modules/s3-bucket/aws"

  bucket = "t360-photos-bucket-private-${random_string.this.result}"
  acl    = "private"
  force_destroy = true

  control_object_ownership = true
  object_ownership         = "ObjectWriter"


  replication_configuration = {
    role = aws_iam_role.replication.arn

    rules = [
      {
        id     = "everything-without-filters"
        status = "Enabled"

        delete_marker_replication = true

        destination = {
          bucket        = "arn:aws:s3:::${local.private_bucket_replica}"
          storage_class = "STANDARD"
        }
      },
    ]
  }

  versioning = {
    enabled = true
  }
}

module "replica_bucket" {
  source = "terraform-aws-modules/s3-bucket/aws"

  providers = {
    aws = aws.region2
  }

  bucket = local.private_bucket_replica
  acl    = "private"
  force_destroy = true
  object_ownership         = "ObjectWriter"
  control_object_ownership = true

  versioning = {
    enabled = true
  }
}



module "s3_bucket_public" {
  source = "terraform-aws-modules/s3-bucket/aws"

  bucket = "t360-photos-bucket-public-${random_string.this.result}"
  acl    = "public-read-write"
  block_public_acls = false
  block_public_policy = false
  ignore_public_acls = false
  restrict_public_buckets = false
  force_destroy = true


  control_object_ownership = true
  object_ownership         = "ObjectWriter"

  attach_policy = true
  policy = <<EOF

  {
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": "*",
      "Action": "s3:GetObject",
      "Resource": "arn:aws:s3:::${local.public_bucket_name}/*"
    }
  ]
}


EOF

  versioning = {
    enabled = true
  }
}


