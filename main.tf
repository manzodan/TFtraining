#
# DO NOT DELETE THESE LINES!
#
# Your AMI ID is:
#
#     ami-66506c1c
#
# Your subnet ID is:
#
#     subnet-ce92e593
#
# Your security group ID is:
#
#     sg-3ee83749
#
# Your Identity is:
#
#     customer-training-tiger
#
variable "aws_access_key" {}

variable "aws_secret_key" {}

variable "aws_region" {
  default = "us-east-1"
}

variable "num_webs" {
  default = "2"
}

terraform {
  backend "atlas" {
    name = "manzodan/training"
  }
}

provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region     = "${var.aws_region}"
}

resource "aws_instance" "web" {
  # ...
  ami                    = "ami-66506c1c"
  instance_type          = "t2.micro"
  subnet_id              = "subnet-ce92e593"
  vpc_security_group_ids = ["sg-3ee83749"]

  tags {
    Identity    = "customer-training-tiger"
    Foo         = "Bar"
    DateCreated = "31.01.2018"
    Name        = "web ${count.index+1}/${var.num_webs}"
  }

  count = 2
}

output "public_dns" {
  value = "${aws_instance.web.*.public_dns}"
}
