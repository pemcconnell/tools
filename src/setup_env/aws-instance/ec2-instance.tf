provider "aws" {
  region = "eu-west-2"
}

data "aws_ami" "base_image" {
  most_recent = true

  filter {
    name   = "name"
    values = ["CentOS Linux 7 x86_64 *"]
  }

  owners = ["679593333241"]
}

resource "aws_instance" "my_instance" {
  ami                         = "${data.aws_ami.base_image.id}"
  availability_zone           = "${var.availability_zone}"
  subnet_id                   = "${var.subnet_id}"
  vpc_security_group_ids      = ["${var.security_group_ids}"]
  instance_type               = "${var.instance_type}"
  key_name                    = "${aws_key_pair.my_pub_ssh_key.id}"
  associate_public_ip_address = true

  root_block_device {
    volume_type           = "gp2"
    volume_size           = 20
    delete_on_termination = true
  }

  tags = {
    Name = "${var.tag}"
  }

  volume_tags {
    Name = "${var.tag}"
  }
}

resource "aws_eip_association" "my_instance_eip_assoc" {
  instance_id   = "${aws_instance.my_instance.id}"
  allocation_id = "${var.elastic_ip_id}"
}

resource "aws_key_pair" "my_pub_ssh_key" {
  key_name   = "${var.tag}_public_key"
  public_key = "${file(var.ssh_pub_key_file)}"
}

variable "tag" {}

variable "availability_zone" {}

variable "subnet_id" {}

variable "instance_type" {}

variable "elastic_ip_id" {}

variable "security_group_ids" {}

variable "ssh_pub_key_file" {
  default = "~/.ssh/id_rsa.pub"
}

# TODO
# - Create ssh key/use local id_rsa one
# - Create SG with your own IP only
# - Create VPC with subnets
# - Parametrize ec2 instance

