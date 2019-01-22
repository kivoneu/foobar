resource "aws_route53_zone" "hosted_zone" {
  name = "${var.domain_name}"
}

resource "aws_s3_bucket" "public_foobar_bucket" {
  bucket = "${var.bucket_name}.${var.domain_name}"
  region = "${var.aws_region}"
  force_destroy = "true"
  website {
    error_document = "${var.error_document}"
    index_document = "${var.index_document}"
  }
}

resource "aws_s3_bucket_object" "index_document_object" {
  bucket = "${aws_s3_bucket.public_foobar_bucket.id}"
  key    = "${var.index_document}"
  source = "./${var.index_document}"
  content_type = "html/text"
}

resource "aws_s3_bucket_policy" "public_foobar_bucket_policy" {
  bucket = "${aws_s3_bucket.public_foobar_bucket.id}"
  policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "PublicReadForGetBucketObjects",
            "Effect": "Allow",
            "Principal": "*",
            "Action": "s3:GetObject",
            "Resource": "${aws_s3_bucket.public_foobar_bucket.arn}/*"
        }
    ]
}
POLICY
}

resource "aws_route53_record" "foobar" {
  zone_id = "${aws_route53_zone.hosted_zone.id}"
  name = "${var.bucket_name}.${var.domain_name}"
  type = "CNAME"
  ttl ="60"
  records= [ "${aws_s3_bucket.public_foobar_bucket.website_endpoint}"]
}
