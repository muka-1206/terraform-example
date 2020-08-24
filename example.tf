terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

provider "aws" {
  profile = "terraform"
  region  = var.region
}

resource "aws_instance" "example" {
  ami           = "ami-0cc75a8978fbbc969"
  instance_type = "t2.micro"
  subnet_id     = "subnet-00d367afc3d3fae51"

  provisioner "local-exec" {
    command = "echo ${aws_instance.example.public_ip} > ip_address.txt"
  }
}
resource "aws_eip" "ip" {
  vpc      = true
  instance = aws_instance.example.id
}