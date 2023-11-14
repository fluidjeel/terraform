provider "aws" {
  region     = "us-east-1"
}

locals {
  tags = {
    Name = "plt-tf-test-eip"
    AppName = "terra-eip-test"
    Backup = "no"
    Environment = "poc"
    DataClassification = "internal"
    InfraOwner = "sre-cloud-reliability@tavisca.com"
    Product = "plt"
    BusinessUnit = "travel.poc"

  }
}

resource "aws_eip" "lb" {
  domain   = "vpc"
  tags = local.tags
}

resource "aws_security_group" "allow_tls" {
  description = "Allow TLS inbound traffic"
  vpc_id      = "vpc-09068aa9f54da8688"


  ingress {
    description      = "TLS from VPC"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["${aws_eip.lb.public_ip}/32"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = local.tags
}