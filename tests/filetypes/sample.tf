# Terraform example to test editor settings

# Define a provider (AWS in this case)
provider "aws" {
  region  = "us-west-2"
  profile = "default"
}

# Input variables
variable "instance_type" {
  description = "Type of instance to be used"
  type        = string
  default     = "t2.micro"
}

variable "instance_count" {
  description = "Number of instances"
  type        = number
  default     = 2
}

variable "enable_monitoring" {
  description = "Whether to enable detailed monitoring"
  type        = bool
  default     = true
}

# Output variables
output "instance_public_ips" {
  description = "The public IP addresses of the EC2 instances"
  value       = aws_instance.example[*].public_ip
}

output "instance_ids" {
  description = "The IDs of the EC2 instances"
  value       = aws_instance.example[*].id
}

# Data source to fetch the latest Amazon Linux AMI
data "aws_ami" "latest_amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

# Define a VPC
resource "aws_vpc" "example" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "example-vpc"
  }
}

# Define a subnet
resource "aws_subnet" "example" {
  vpc_id            = aws_vpc.example.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-west-2a"

  tags = {
    Name = "example-subnet"
  }
}

# Define an Internet Gateway
resource "aws_internet_gateway" "example" {
  vpc_id = aws_vpc.example.id

  tags = {
    Name = "example-igw"
  }
}

# Define a Route Table
resource "aws_route_table" "example" {
  vpc_id = aws_vpc.example.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.example.id
  }

  tags = {
    Name = "example-route-table"
  }
}

# Associate the Route Table with the Subnet
resource "aws_route_table_association" "example" {
  subnet_id      = aws_subnet.example.id
  route_table_id = aws_route_table.example.id
}

# Define a security group
resource "aws_security_group" "example" {
  vpc_id = aws_vpc.example.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "example-security-group"
  }
}

# Define an EC2 instance with a dynamic block
resource "aws_instance" "example" {
  count = var.instance_count

  ami                         = data.aws_ami.latest_amazon_linux.id
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.example.id
  associate_public_ip_address = true
  monitoring                  = var.enable_monitoring

  tags = {
    Name = "example-instance-${count.index}"
  }

  dynamic "root_block_device" {
    for_each = aws_instance.example
    content {
      volume_size = 30
      volume_type = "gp2"
      delete_on_termination = true
    }
  }

  provisioner "local-exec" {
    command = "echo Instance ${self.id} is up and running."
  }
}

# Locals for reusable values
locals {
  instance_name_prefix = "my-instance"
  env                  = "dev"
}

# Using locals in a resource
resource "aws_instance" "extra" {
  ami           = data.aws_ami.latest_amazon_linux.id
  instance_type = "t3.micro"

  tags = {
    Name = "${local.instance_name_prefix}-${local.env}"
  }
}

# Output the local values for debugging purposes
output "instance_name_prefix" {
  value = local.instance_name_prefix
}

# Output the local environment
output "env" {
  value = local.env
}

# Terraform backend configuration (S3 and DynamoDB for remote state)
terraform {
  backend "s3" {
    bucket         = "my-terraform-state"
    key            = "global/s3/terraform.tfstate"
    region         = "us-west-2"
    dynamodb_table = "terraform-lock"
    encrypt        = true
  }
}

# Terraform provider version constraint
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }

  required_version = ">= 1.0"
}

# Example of a null_resource and usage of depends_on
resource "null_resource" "example" {
  provisioner "local-exec" {
    command = "echo 'Running a local command!'"
  }

  depends_on = [aws_instance.example]
}

