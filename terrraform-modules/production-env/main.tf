provider "aws" {
  region = var.region_name
}

terraform {
  backend "s3" {
    bucket = "ankiterra1234"
    key    = "production.tfstate"
    region = "us-east-1"
  }
}
