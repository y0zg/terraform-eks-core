terraform {
  required_version = "0.12.13"

  backend "s3" {
    bucket         = ""
    key            = ""
    region         = ""
    acl            = ""
    dynamodb_table = ""
  }
}
