provider "aws" {
  region     = "us-east-1"
}

locals {
  tags = {
    Name = "plt-tf-test-ec2"
    AppName = "terra-ec2-test"
    Backup = "no"
    Environment = "poc"
    DataClassification = "internal"
    InfraOwner = "sre-cloud-reliability@tavisca.com"
    Product = "plt"
    BusinessUnit = "travel.poc"

  }
}

resource "aws_instance" "tfec2" {
    ami = "ami-0366c1a458e462680"
    instance_type = "t2.micro"
    tags = local.tags
    volume_tags = local.tags
    
}
