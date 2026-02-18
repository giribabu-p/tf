/*
module "vpc" {
  source              = "../../modules/vpc"
  vpc_cidr_block      = var.vpc_cidr_block
  pub_sub_azs         = var.pub_sub_azs
  pub_sub_cidr_block  = var.pub_sub_cidr_block
  sub_count           = var.sub_count
  network_tags        = var.network_tags
  priv_sub_azs        = var.priv_sub_azs
  priv_sub_cidr_block = var.priv_sub_cidr_block
  global_route        = var.global_route
  env                 = var.env
}

module "ec2" {
  source                 = "../../modules/ec2"
  sg_name                = var.sg_name
  sg_info                = var.sg_info
  vpc_id                 = module.vpc.vpc_id
  sg_rules_mongo         = var.sg_rules_mongo
  sg_rules_common        = var.sg_rules_common
  sg_rules_ftp           = var.sg_rules_ftp
  sg_rules_kube          = var.sg_rules_kube
  sg_rules_elk           = var.sg_rules_elk
  sg_rules_grafana       = var.sg_rules_grafana
  sg_rules_hazelcast     = var.sg_rules_hazelcast
  sg_rules_public_nginx  = var.sg_rules_public_nginx
  sg_rules_bastion       = var.sg_rules_bastion
  sg_rules_kafka         = var.sg_rules_kafka
  env                    = var.env
  instance_tags          = var.instance_tags
  instance_count         = var.instance_count
  instance_type          = var.instance_type
  key_name               = var.key_name
  priv_sub_id            = module.vpc.priv_sub_names[*]
  pub_sub_id             = module.vpc.pub_sub_names[*]
  priv_sub_azs           = module.vpc.priv_sub_azs[*]
  data_vol_size          = var.data_vol_size
  root_vol_size          = var.root_vol_size
  volume_type            = var.volume_type
}
*/
module "eks" {
  source                  = "../../modules/eks"
  cluster_name            = var.cluster_name      #"eks"
  node_group_name         = var.node_group_name   #"eks-node"
  eks_instance_type       = var.eks_instance_type #"t2.medium"
  eks_desired_size        = var.eks_desired_size  #2
  eks_max_size            = var.eks_max_size      #3
  eks_min_size            = var.eks_min_size      #1
  #pub_sub_names           = module.vpc.pub_sub_names[*]
  #priv_sub_names          = module.vpc.priv_sub_names[*]
  #pub_sub_names = ["subnet-0f3b0d01a275f0250","subnet-0895d7b63609120af"]
  #priv_sub_names = ["subnet-0eb6c72eaa3bce2dc","subnet-01844355bd3b8abbf"]
  sg_rules_eks_additional = var.sg_rules_eks_additional
  #vpc_id = module.vpc.vpc_id
  #vpc_id = ["vpc-08fcbad31b564128e"]
  sg_info = var.sg_info
  sg_name = var.sg_name
  node_disk_size = var.node_disk_size
}
