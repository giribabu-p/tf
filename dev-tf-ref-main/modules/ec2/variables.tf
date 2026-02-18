variable "vpc_id" {}

variable "sg_name" {}

variable "sg_info" {}

variable "env" {}

variable "sg_rules_mongo" { }
variable "sg_rules_kafka" { }
variable "sg_rules_bastion" { }
variable "sg_rules_kube" { }
variable "sg_rules_ftp" { }
variable "sg_rules_elk" { }
variable "sg_rules_grafana" { }
variable "sg_rules_common" { }
variable "sg_rules_public_nginx" { }
variable "sg_rules_hazelcast" { }
#variable "sg_ips" {}
#variable "sg_ports" {}

variable "instance_tags" {}

locals {
  ec2_common_tags = {
    Terraform = "true"
    Environment = "stage"
    Timestamp = formatdate("DD-MMM-YYYY hh:mm:ss ZZZ", timestamp())
  }
}
variable "instance_type" {}
variable "volume_type" {}
variable "instance_count" {}
variable "priv_sub_id" {}
variable "pub_sub_id" {}
variable "priv_sub_azs" {}
variable "key_name" {}
variable "data_vol_size" {}
variable "root_vol_size" {}