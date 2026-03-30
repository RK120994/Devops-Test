terraform {
  backend "s3" {
    bucket = "rk-tf-state-1774599083"
    key    = "secure-microservices/terraform.tfstate"
    region = "us-east-1"
  }
}