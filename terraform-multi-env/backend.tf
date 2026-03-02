terraform {
  backend "s3" {
    bucket = "ankiterra1234"
    key    = "Workspaces.tfstate"
    region = "us-east-1"
  }
}