provider "aws" {
  region = "us-east-1"
  //access_key = "AKIA5TKXC5FLNJOYPNU3"
  //secret_key = "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"
  
}
variable "cidr_block" {
  description = "cidr block for subnet1 and subnet2"
  type = list(string)
  
}
//Creating varibles
//variable "subnet_cidr_block_2" {
  //description = "subnet cidr block 2"
  


resource "aws_vpc" "development-vpc" {
  cidr_block = "10.0.0.0/16"
  
}
resource "aws_subnet" "dev-subnet-1" {
  vpc_id = aws_vpc.development-vpc.id
  cidr_block = var.cidr_block[0]
  availability_zone = "us-east-1a"
  tags = {
     Name: "development",
     vpc_env: "dev"
  }
  
}
//Creating subnet on existing vcp,use Data Resources-It helps us to query the existing
data "aws_vpc" "existing_vpc" {
  default = true
}

resource "aws_subnet" "dev-subnet-2" {
  vpc_id = data.aws_vpc.existing_vpc.id
  cidr_block = var.cidr_block[1]
  availability_zone = "us-east-1a"
  tags = {
     Name: "subnet-1-default"
  }
}

output "dev-vpc-id" {
  value = aws_vpc.development-vpc.id
  
}
output "dev-subnet-id" {
  value = aws_subnet.dev-subnet-1.id
  
}