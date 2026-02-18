/*
output "common_security_group" {
  value = aws_security_group.common_sg.vpc_id
}

output "mongo_security_group" {
  value = aws_security_group.mongo_sg.vpc_id
}


output "kafka_servers_ips" {
  value = {
      for server in aws_instance.kafka-servers:
      server.id => server.private_ip
  }
}
output "hazelcast_servers_ips" {
  value = {
      for server in aws_instance.hazelcast-servers:
      server.id => server.private_ip
  }
}

output "elkserver_ip" {
  value = {
      for server in aws_instance.elkserver:
      server.id => server.private_ip
      #instance.tags.Name
  }
}
output "grafana-server_ips" {
  value = {
      for server in aws_instance.grafana-server:
      server.id => server.private_ip
  }
}
output "ftpserver_ip" {
  value = {
      for server in aws_instance.ftpserver:
      server.id => server.private_ip
  }
}
output "kube-server_ips" {
  value = {
      for server in aws_instance.kube-server:
      server.id => server.private_ip
  }
}

output "mongo_message_servers_ips" {
  value = {
      for server in aws_instance.mongo-servers:
      server.id => server.private_ip
  }
}
output "mongo_analytics_servers_ips" {
  value = {
      for server in aws_instance.mongo-analytics-servers:
      server.id => server.private_ip
  }
}
output "mongo_rest_servers_ips" {
  value = {
      for server in aws_instance.mongo-rest-servers:
      server.id => server.private_ip
  }
}
output "mongo_opsmanager-server_ip" {
  value = {
      for server in aws_instance.opsmanager-server:
      server.id => server.private_ip
  }
}
output "mongo_opsmanager_server_ip" {
  value = {
      for server in aws_instance.opsmanager-server:
      server.id => server.private_ip
  }
}
output "mongo_history_server_ip" {
  value = {
      for server in aws_instance.mongo-history-server:
      server.id => server.private_ip
  }
}
output "mongo_googleservice_server_ip" {
  value = {
      for server in aws_instance.mongo-googleservice-server:
      server.id => server.private_ip
  }
}


*/

/*
#########
output "instance_name" {
   description = "Tags of the EC2 instance"
-  value        = aws_instance.web_app.tags
+  value        = [for instance in aws_instance.web_app: instance.tags.Name]
}
*/