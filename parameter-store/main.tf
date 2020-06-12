terraform {
  backend "s3" {
    bucket                  = "carlsberg-tf-states"
    key                     = "infra/aws/carlsberg-dev-4834-5903-6065/acn-gbs-cxproject-dev-01/dev/ct-geoip-service-be/parameter-store/state.tf"
    region                  = "eu-west-1"
    shared_credentials_file = "~/.aws/credentials"
    profile                 = "cx-tf-states"
  }
}

provider "aws" {
  region                    = "eu-west-1"
  shared_credentials_file   = "~/.aws/credentials"
  profile                   = "Carlsberg-Dev"
}

resource "aws_ssm_parameter" "profile" {
  name        = "/${var.environment}/${var.app_name}/SPRING_PROFILES_ACTIVE"
  description = "Spring profiles"
  type        = "String"
  value       = var.SPRING_PROFILES_ACTIVE

  tags = {
    environment = var.environment
  }
}


resource "aws_ssm_parameter" "server-port" {
  name        = "/${var.environment}/${var.app_name}/SERVER_PORT"
  description = "The server port"
  type        = "String"
  value       = var.SERVER_PORT

  tags = {
    environment = var.environment
  }
}
