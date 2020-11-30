terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
    random = {
      source = "hashicorp/random"
    }
  }

  backend "remote" {
    organization = "BambeeQ"

    workspaces {
      name = "clearbit"
    }
  }
}

provider "aws" {
  region = "us-west-2"
}

provider "random" {}

resource "aws_instance" "web" {
  ami         = "ami-0a741b782c2c8632d"
  instance_type = "t2.micro"
  subnet_id = "subnet-f4d3a0ad"
  key_name = "BQ-EKS"
  vpc_security_group_ids = "sg-0161c2c1d66785530"
}

output "web-address" {
  value = "${aws_instance.web.public_dns}:8080"
}
