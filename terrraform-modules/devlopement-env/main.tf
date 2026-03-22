provider "aws" {
  region = "us-east-1"
}

terraform {
  backend "s3" {
    bucket = "ankiterra1234"
    key    = "developement.tfstate"
    region = "us-east-1"
  }
}