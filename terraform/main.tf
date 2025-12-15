terraform {
  required_version = ">= 1.6.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "eu-west-1"
}

data "aws_subnet" "public" {
  filter {
    name   = "tag:Tier"
    values = ["public"]
  }
  
  filter {
    name   = "availability-zone"
    values = ["eu-west-1a"]
  }
}


resource "aws_instance" "nginx-node" {
  ami                    = "ami-0dc69fef38832b690"
  instance_type          = "c7i-flex.large"
  subnet_id              = data.aws_subnet.public.id
  vpc_security_group_ids = ["sg-00fc85f260a51a4dd"]
  key_name               = "aws-key"

  tags = {
    Name = "nginx-node"
    Type = "Nginx"
  }
}


resource "aws_instance" "python-node" {
  ami                    = "ami-07b5321568e2b46bf"
  instance_type          = "c7i-flex.large"
  subnet_id              = data.aws_subnet.public.id
  vpc_security_group_ids = ["sg-00fc85f260a51a4dd"]
  key_name               = "aws-key"

  tags = {
    Name = "python-node"
    Type = "Python"
  }
}


resource "aws_instance" "java-node" {
  ami                    = "ami-07327aae308bf3bde"
  instance_type          = "c7i-flex.large"
  subnet_id              = data.aws_subnet.public.id
  vpc_security_group_ids = ["sg-00fc85f260a51a4dd"]
  key_name               = "aws-key"

  tags = {
    Name = "java-node"
    Type = "Java"
  }
}


output "nginx_instance_ip" {
  value       = aws_instance.nginx-node.public_ip
  description = "Public IP of Nginx instance"
}

output "python_instance_ip" {
  value       = aws_instance.python-node.public_ip
  description = "Public IP of Python instance"
}

output "java_instance_ip" {
  value       = aws_instance.java-node.public_ip
  description = "Public IP of Java instance"
}

output "nginx_instance_id" {
  value       = aws_instance.nginx-node.id
  description = "Instance ID of Nginx server"
}

output "python_instance_id" {
  value       = aws_instance.python-node.id
  description = "Instance ID of Python server"
}

output "java_instance_id" {
  value       = aws_instance.java-node.id
  description = "Instance ID of Java server"
}