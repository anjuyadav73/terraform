provider "aws" {
  region = "us-east-2"
  assume_role {
       role_arn = "arn:aws:iam::${var.account-id}:role/${var.role-id}"
  }
}
