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
  user_data     = <<-EOF
                  #!/bin/bash
                  sudo su
                  apt -y install httpd
                  echo "<p> My Instance! </p>" >> /var/www/html/index.html
                  sudo systemctl enable httpd
                  sudo systemctl start httpd
                  EOF
}

output "DNS" {
  value = aws_instance.myInstance.public_dns
}
