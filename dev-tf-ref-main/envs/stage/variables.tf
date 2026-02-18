/*
variable "aws_region" {}
variable "vpc_cidr_block" {}

locals {
  abcd = "10.2.3.4/16"
}
variable "pub_sub_cidr_block" {}
variable "pub_sub_azs" {}
variable "sub_count" {}
variable "priv_sub_cidr_block" {}
variable "network_tags" {}
variable "priv_sub_azs" {}
variable "global_route" {}
variable "env" {}

##########################
#variable "vpc_id" {}
variable "sg_name" {}
variable "sg_info" {}
#variable "env" {}
variable "sg_rules_mongo" {}
variable "sg_rules_kafka" {}
variable "sg_rules_bastion" {}
variable "sg_rules_kube" {}
variable "sg_rules_ftp" {}
variable "sg_rules_elk" {}
variable "sg_rules_grafana" {}
variable "sg_rules_common" {}
variable "sg_rules_public_nginx" {}
variable "sg_rules_hazelcast" {}
#variable "sg_ips" {}
#variable "sg_ports" {}
variable "instance_tags" {}
variable "instance_type" {}
variable "volume_type" {}
variable "instance_count" {}
#variable "priv_sub_id" {}
variable "key_name" {}
variable "data_vol_size" {}
variable "root_vol_size" {}
*/
##################
variable "cluster_name" {}
variable "eks_instance_type" {}
variable "eks_desired_size" {}
variable "eks_min_size" {}
variable "eks_max_size" {}
variable "node_group_name" {}
variable "sg_rules_eks_additional" {}
variable "sg_name" {}
variable "sg_info" {}
variable "node_disk_size" { }

