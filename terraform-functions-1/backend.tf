terraform {
  backend "s3" {
    bucket = "ankiterra1234"
    key    = "ankiterra1234.tfstate"
    region = "us-east-1"
  }
}