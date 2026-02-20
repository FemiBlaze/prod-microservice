provider "aws" {
  region = "us-east-1"

  default_tags {
    tags = {
      Project     = "prod-microservice"
      Environment = "production"
      Owner       = "Blaze"
      ManagedBy   = "Terraform"
    }
  }
}

