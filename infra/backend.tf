terraform {
  backend "s3" {
    bucket         = "blaze-prod-terraform-state"
    key            = "ecs-prod/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-state-lock"
    encrypt        = true
  }
}

