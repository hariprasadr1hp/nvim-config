# HCL (HashiCorp Configuration Language) example to test editor settings

# Provider configuration
provider "aws" {
  region = "us-west-2"
}

# Define a resource (AWS EC2 instance)
resource "aws_instance" "example" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"

  tags = {
    Name = "example-instance"
  }
}

# Define a variable
variable "instance_count" {
  description = "Number of EC2 instances to create"
  type        = number
  default     = 1
}

# Define an output value
output "instance_id" {
  description = "The ID of the EC2 instance"
  value       = aws_instance.example.id
}

# Define a data source (fetching information)
data "aws_ami" "latest" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

# Using locals for computed values
locals {
  environment = "production"
  instance_tags = {
    Environment = local.environment
    Project     = "example-project"
  }
}

# Resource using local values
resource "aws_instance" "prod_instance" {
  ami           = data.aws_ami.latest.id
  instance_type = "t2.micro"

  tags = local.instance_tags
}

# Module usage example
module "network" {
  source = "./modules/network"
  vpc_id = "vpc-12345678"
}

# Terraform backend configuration
terraform {
  backend "s3" {
    bucket = "my-terraform-state"
    key    = "state/terraform.tfstate"
    region = "us-west-2"
  }
}

