terraform {
  required_version = "0.12.6"

  backend "s3" {
    bucket         = "terraform-core-platform-556969431317"
    key            = "eu-central-1/terraform-aws-core-platform/terraform.tfstate"
    region         = "eu-central-1"
    acl            = "bucket-owner-full-control"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}
