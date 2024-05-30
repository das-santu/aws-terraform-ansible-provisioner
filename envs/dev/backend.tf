terraform {
  backend "s3" {
    bucket = "my-tfcicd-backend-bucket"
    key    = "envs/dev/terraform.tfstate"
    region = "ap-south-1"
  }
}