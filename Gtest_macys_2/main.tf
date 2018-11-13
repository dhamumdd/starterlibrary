#####################################################################
##
##      Created 11/13/18 by admin. for Gtest_macys_2
##
#####################################################################

terraform {
  required_version = "> 0.8.0"
}

provider "aws" {
  access_key = "${var.aws_access_id}"
  secret_key = "${var.aws_secret_key}"
  region     = "${var.region}"
  version = "~> 1.8"
}


resource "aws_instance" "Gtest_macys_2_instance" {
  ami = "${var.Gtest_macys_2_instance_ami}"
  key_name = "${aws_key_pair.auth.id}"
  instance_type = "${var.Gtest_macys_2_instance_aws_instance_type}"
  availability_zone = "${var.availability_zone}"
  subnet_id  = "${aws_subnet.Gtest_macys_sub.id}"
  tags {
    Name = "${var.Gtest_macys_2_instance_name}"
  }
}

resource "tls_private_key" "ssh" {
    algorithm = "RSA"
}

resource "aws_key_pair" "auth" {
    key_name = "${var.aws_key_pair_name}"
    public_key = "${tls_private_key.ssh.public_key_openssh}"
}

resource "aws_vpc" "Gteat_macys_test2_vpc" {
  cidr_block           = "0.0.0.0/0"
  enable_dns_hostnames = true

  tags {
    Name = "${var.network_name_prefix}"
  }
}

resource "aws_subnet" "Gtest_macys_sub" {
  vpc_id = "${aws_vpc.Gteat_macys_test2_vpc.id}"
  cidr_block = "10.0.1.0/24"
  availability_zone = "${var.availability_zone}"
  tags {
    Name = "Main"
  }
}