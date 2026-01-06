terraform {
  backend "s3" {
    bucket         = "terraform-state-rana"
    key            = "network/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-lock"
    encrypt        = true
  }
}
