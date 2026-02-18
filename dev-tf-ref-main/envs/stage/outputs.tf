/*
output "vpc_id" {
  value = module.vpc.vpc_id
}

output "vpc_cidr" {
  value = module.vpc.vpc_cidr
}

output "pub_sub_names" {
  value = module.vpc.pub_sub_names
}


output "pub_sub_cidrs" {
  value = module.vpc.pub_sub_cidrs
}

output "priv_sub_names" {
  value = module.vpc.priv_sub_names
}

output "priv_sub_cidrs" {
  value = module.vpc.priv_sub_cidrs
}

output "vpc_igw" {
  value = module.vpc.vpc_igw
}

output "nat_gw" {
  value = module.vpc.nat_gw
}

/*
###ec2
output "common_security_group" {
  value = module.ec2.common_sg
}

output "mongo_security_group" {
  value = module.ec2.mongo_sg
}


output "kafka_servers_ips" {
  value = module.ec2.kafka_servers_ips
}
output "hazelcast_servers_ips" {
  value = module.ec2.hazelcast_servers_ips
}

output "elkserver_ip" {
  value = module.ec2.elkserver_ip
}
output "grafana-server_ips" {
  value = module.ec2.grafana-server_ips
}
output "ftpserver_ip" {
  value = module.ec2.ftpserver_ip
}
output "kube-server_ips" {
  value = module.ec2.kube-server_ips
}

output "mongo_message_servers_ips" {
  value = module.ec2.mongo_message_servers_ips
}
output "mongo_analytics_servers_ips" {
  value = module.ec2.mongo_analytics_servers_ips
}
output "mongo_rest_servers_ips" {
  value = module.ec2.mongo_rest_servers_ips
}
output "mongo_opsmanager-server_ip" {
  value = module.ec2.mongo_opsmanager-server_ip
}
output "mongo_opsmanager_server_ip" {
  value = module.ec2.mongo_opsmanager_server_ip
}
output "mongo_history_server_ip" {
  value = module.ec2.mongo_history_server_ip
}
output "mongo_googleservice_server_ip" {
  value = module.ec2.mongo_googleservice_server_ip
}

*/


output "kubeconfig-certificate-authority-data" {
  value = module.eks.kubeconfig-certificate-authority-data
}

output "cluster-arn" {
  value = module.eks.cluster-arn
}
output "cluster-endpoint" {
  value = module.eks.cluster-endpoint
}
output "cluster-status" {
  value = module.eks.cluster-status
}
