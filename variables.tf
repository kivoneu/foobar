variable "aws_region" {
  description = "Primary terraform region"
}

variable "domain_name" {
  description = "Default domain"
}

variable "bucket_name" {
  description = "Bucket name"
}

variable "index_document" {
  description = "Index document"
  default = "index.html"
}

variable "error_document" {
  description = "Error document"
  default = "error.html"
}