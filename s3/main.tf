variable workspace_iam_roles {
    type = map
    default = {
        dev = "arn:aws:iam::183679200364:role/clearbit-testing-role"
        mgmt = "arn:aws:iam::751328848357:role/clearbit-testing-role"
    }
}


provider "aws" {
    region = var.region
    assume_role {
        role_arn = var.workspace_iam_roles[terraform.workspace]
    }
}

terraform {
    required_version = ">= 0.13.5"
    backend "s3" {
        bucket = "clrbit-shared-tfstate"
        #profile = "mgmt"
        key = "aws-infra/s3-test/terraform.tfstate"
        region = "us-west-2"
        encrypt = true
        dynamodb_table = "terraform-state-lock"
    }
}

variable region {
        default = "us-west-2"
}
