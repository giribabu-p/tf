variable "vpc_cidr_block" { }
variable "sub_count" { }   
variable "pub_sub_cidr_block" { }
variable "network_tags" { }
variable "pub_sub_azs" { }
variable "priv_sub_cidr_block" { }
variable "priv_sub_azs" { }
variable "global_route" {}
locals {
  vpc_common_tags = {
    Team       = "DevOps"
    Terraform = "true"
    Environment = "stage"
    #Timestamp = format("%s", formatdate("DD-MMM-YYYY hh:mm:ss",timeadd(timestamp(), "5h30m")))
    Timestamp = formatdate("DD-MMM-YYYY hh:mm:ss ZZZ", timestamp())
  }
}

variable "env" { }