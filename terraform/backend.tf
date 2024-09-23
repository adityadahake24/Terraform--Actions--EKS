terraform {
  backend "s3" {
    bucket         = "autok8s-terraform-state"
    key            = "path/to/my/key"
    region         = "ap-south-1"
    dynamodb_table = "terraform_locks"
    encrypt        = true
  }
}
