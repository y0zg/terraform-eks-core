provider "aws" {
  version = "= 2.28.1"
  region  = var.region
}

provider "local" {
  version = "= 1.3.0"
}

provider "null" {
  version = "= 2.1.2"
}

provider "template" {
  version = "=  2.1.2"
}
