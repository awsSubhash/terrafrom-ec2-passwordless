terraform {
  backend "s3" {
    bucket         = "terraform-state-subhash"
    key            = "ec2/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-lock-table"
    encrypt        = true
  }
}
