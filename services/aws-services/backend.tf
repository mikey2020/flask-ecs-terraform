terraform {
  backend "s3" {
    bucket = "sm-ascentregtech-terraform"
    key    = "aws-services/terraform.tfstate"
    region = "us-east-2"

    dynamodb_table = "sm-ascentregtech-terraform-table"
    encrypt        = true
  }
}
