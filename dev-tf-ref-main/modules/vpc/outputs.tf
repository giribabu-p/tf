output "vpc_id" {
  value = aws_vpc.demovpc.id
}

output "vpc_cidr" {
  value = aws_vpc.demovpc.cidr_block
}

output "pub_sub_names" {
  value = aws_subnet.demo-pub-subnet[*].id
}

output "pub_sub_cidrs" {
  value = aws_subnet.demo-pub-subnet[*].cidr_block
}

output "priv_sub_names" {
  value = aws_subnet.demo-priv-subnet[*].id
}

output "priv_sub_cidrs" {
  value = aws_subnet.demo-priv-subnet[*].cidr_block
}

output "priv_sub_azs" {
  value = aws_subnet.demo-priv-subnet[*].availability_zone
}
output "vpc_igw" {
  value = aws_internet_gateway.demo-igw.id
}

output "nat_gw" {
  value = aws_nat_gateway.demo-nat.allocation_id
}


