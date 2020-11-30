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
-   organization = "REPLACE_ME"
+   organization = "BambeeQ"

    workspaces {
      name = "clearbit"
    }
  }
}
