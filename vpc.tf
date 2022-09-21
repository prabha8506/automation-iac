#Create VPC with Stage
 data "aws_availability_zones" "availablezone" {
   state = "available"
 }

resource "aws_vpc" "vpc" {
  cidr_block       = "10.1.0.0/16"
  instance_tenancy = "default"
  enable_dns_hostnames = "true"

  tags = {
    Name = "tf-stage-vpc"
    Terraform = "True"
  }
}

## aws_internet_gateway.igw will be created
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "tf-stage-vpc"
  }
  depends_on = [
    aws_vpc.vpc
  ]
}

#Create Subnet
resource "aws_subnet" "vpc" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = "10.1.0.0/24"
 map_public_ip_on_launch = "true"
 availability_zone = data.aws_availability_zones.available.names[0]
   tags = {
    Name = "tf-subnet-Public-1"
 }
 }
 resource "aws_subnet" "vpca" {
  vpc_id     = aws_vpc.vpc.id
   cidr_block = "10.1.1.0/24"
  map_public_ip_on_launch = "true"
  availability_zone = data.aws_availability_zones.available.names[1]

   tags = {
     Name = "tf-subnet-Public-2"
   }
 }
 resource "aws_subnet" "vpcb" {
   vpc_id     = aws_vpc.vpc.id
   cidr_block = "10.1.2.0/24"
   map_public_ip_on_launch = "true"
   availability_zone = data.aws_availability_zones.available.names[2]

  tags = {
     Name = "tf-subnet-Public-3"
   }
 }