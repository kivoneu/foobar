provider "aws" {
  version                     = "~> 1.26"
  region                      = "${var.aws_region}"
  skip_credentials_validation = true
}
