# Create a VPC
resource "aws_vpc" "main_vpc" {
  cidr_block = var.vpc_cidr
  instance_tenancy = "default"

  tags = {
    "Name" = "Main VPC" 
  }
}

# create two subnets 

resource "aws_subnet" "main_subnet" {
  vpc_id     = aws_vpc.main_vpc.id
  count = length(var.vpc_subnets_cidr)
  cidr_block = var.vpc_subnets_cidr[count.index]
  availability_zone = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name = var.subnet_names[count.index]
  }
}

# create an internet gateway 
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main_vpc.id

  tags = {
    Name = "internet gateway"
  }
}

#create a route to route traffic from public subnet to private subnet
resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.main_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "Route Table"
  }
}

resource "aws_route_table_association" "route_table_assoc" {
  count = length(var.vpc_subnets_cidr)
  subnet_id      = aws_subnet.main_subnet[count.index].id
  route_table_id = aws_route_table.rt.id
}