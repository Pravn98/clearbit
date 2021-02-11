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
  region = "us-west-1"
}

provider "random" {}

resource "aws_instance" "myInstance" {
  ami           = "ami-0a741b782c2c8632d"
  instance_type = "m5.large"
  subnet_id     = "subnet-f4d3a0ad"
  key_name      = "BQ-EKS"
  user_data     = <<-EOF
                  #!/bin/bash
                  sudo su
                  apt update
                  apt -y install apache2
                  echo "<p> My Instance! </p>" >> /var/www/html/index.html
                  sudo systemctl enable apache2
                  sudo systemctl start apache2
                  EOF
}

output "DNS" {
  value = aws_instance.myInstance.public_dns
}
output "currentworkspace" {
  value = terraform.workspace
}
