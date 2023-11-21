provider "aws" {
  region     = "us-east-1"
}

locals {
  tags = {
    # Name = "plt-tf-test-ec2"
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
    instance_type = var.instancetype
    subnet_id = "subnet-0b05147c3d52f1f77"
    iam_instance_profile = "terraform-role"
    key_name = "terraform"
    # count = var.isTest == true ? 2 : 0

    #tags = local.tags
    volume_tags = local.tags
    tags = local.tags /*{
      # Name = "plt-tf-test-ec2${count.index}"
      local.tags
    }*/

    provisioner "local-exec" {
    command = "echo ${aws_instance.tfec2.private_ip} >> private_ips.txt"
  }

}
