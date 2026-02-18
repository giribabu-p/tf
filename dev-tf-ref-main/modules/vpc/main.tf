#vpc creation
resource "aws_vpc" "demovpc" {
  cidr_block = var.vpc_cidr_block
  instance_tenancy = "default"
  enable_dns_hostnames = "true"
  enable_dns_support = "true"
  
  tags = merge( { "Name" = "${var.env}-vpc"}, local.vpc_common_tags )
}

resource "aws_internet_gateway" "demo-igw" {
  vpc_id = aws_vpc.demovpc.id
  tags = merge( { "Name" = "${var.env}-igw"}, local.vpc_common_tags )
}

resource "aws_eip" "nat-eip" {
  vpc = true
  tags = merge( { "Name" = "${var.env}-nateip"}, local.vpc_common_tags )
}
resource "aws_nat_gateway" "demo-nat" {
  allocation_id = aws_eip.nat-eip.id
  subnet_id = aws_subnet.demo-pub-subnet[0].id 
  tags = merge( { "Name" = "${var.env}-natgw"}, local.vpc_common_tags )
}
/*
data "aws_availability_zone" "available" {
  
} 
*/
##two pubic subnets creation 
resource "aws_subnet" "demo-pub-subnet" {
 count = var.sub_count["public"]
 map_public_ip_on_launch = "true"
 vpc_id =  aws_vpc.demovpc.id
 cidr_block = var.pub_sub_cidr_block[count.index] #list of ids
 availability_zone = var.pub_sub_azs[count.index] #list of zones
 tags = merge( { "Name" = "${var.env}-${var.network_tags["pub_sub"]}-${count.index + 1}"}, local.vpc_common_tags )
}


##three private subnets creation 
resource "aws_subnet" "demo-priv-subnet" {
 count = var.sub_count["private"]
 map_public_ip_on_launch = "false"
 vpc_id =  aws_vpc.demovpc.id
 cidr_block = var.priv_sub_cidr_block[count.index] #list of ids
 availability_zone = var.priv_sub_azs[count.index] #list of zones

 tags = merge( { "Name" = "${var.env}-${var.network_tags["priv_sub"]}-${count.index + 1}"}, local.vpc_common_tags )

}

#pub-route table creation
resource "aws_route_table" "demo-pub-rt" {
  vpc_id = aws_vpc.demovpc.id
  route {
        cidr_block = var.global_route
        gateway_id = aws_internet_gateway.demo-igw.id 
     }
 tags = merge( { Name = "${var.env}-${var.network_tags["priv_rt"]}" } , local.vpc_common_tags )

}

#pub-route-tabe association
resource "aws_route_table_association" "pub-rt-assc" {
  count = var.sub_count["public"]
  subnet_id =  aws_subnet.demo-pub-subnet[count.index].id 
  route_table_id = aws_route_table.demo-pub-rt.id
}

#priv-route table creation
resource "aws_route_table" "demo-priv-rt" {
  vpc_id = aws_vpc.demovpc.id
  route {
        cidr_block = var.global_route
        gateway_id = aws_nat_gateway.demo-nat.id 
   }
  tags = merge( { "Name" = "${var.env}-${var.network_tags["priv_rt"]}"}, local.vpc_common_tags )

}

#priv-route-tabe association
resource "aws_route_table_association" "priv-rt-assc" {
  count = var.sub_count["private"]
  subnet_id = aws_subnet.demo-priv-subnet[count.index].id
  route_table_id = aws_route_table.demo-priv-rt.id
}

