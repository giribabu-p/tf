###mongo-security-group##########
resource "aws_security_group" "mongo_sg" {
  name = var.sg_name["mongo"]
  description = var.sg_info["mongo"]
  vpc_id = var.vpc_id
  egress {
      from_port = "0"
      to_port = "0"
      protocol = "-1"
      cidr_blocks = [ "0.0.0.0/0" ]
  }
  tags = merge( { "Name" = var.sg_name["mongo"] }, local.ec2_common_tags )
}

resource "aws_security_group_rule" "sg_mongo_ingress_rules" {
  for_each          = var.sg_rules_mongo
  type              = "ingress"
  from_port         = each.value.from
  to_port           = each.value.to
  protocol          = each.value.proto
  cidr_blocks       = [each.value.cidr]
  description       = each.value.desc
  security_group_id = aws_security_group.mongo_sg.id
}

/*
resource "aws_security_group_rule" "sg_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  description       = "All egress traffic"
  security_group_id = [ aws_security_group.mongo_sg.id  ]
}*/
###common-sg#########
resource "aws_security_group" "common_sg" {
  name = var.sg_name["common"]
  description = var.sg_info["common"]
  vpc_id = var.vpc_id
  egress {
      from_port = "0"
      to_port = "0"
      protocol = "-1"
      cidr_blocks = [ "0.0.0.0/0" ]
  }
  tags = merge( { "Name" = var.sg_name["common"] }, local.ec2_common_tags )
}

resource "aws_security_group_rule" "sg_common_ingress_rules" {
  for_each          = var.sg_rules_common
  type              = "ingress"
  from_port         = each.value.from
  to_port           = each.value.to
  protocol          = each.value.proto
  cidr_blocks       = [each.value.cidr]
  description       = each.value.desc
  security_group_id = aws_security_group.common_sg.id
}

###kafka-sg###
resource "aws_security_group" "kafka_sg" {
  name = var.sg_name["kafka"]
  description = var.sg_info["kafka"]
  vpc_id = var.vpc_id
  egress {
      from_port = "0"
      to_port = "0"
      protocol = "-1"
      cidr_blocks = [ "0.0.0.0/0" ]
  }
  tags = merge( { "Name" = var.sg_name["kafka"] }, local.ec2_common_tags )
}

resource "aws_security_group_rule" "sg_kafka_ingress_rules" {
  for_each          = var.sg_rules_kafka
  type              = "ingress"
  from_port         = each.value.from
  to_port           = each.value.to
  protocol          = each.value.proto
  cidr_blocks       = [each.value.cidr]
  description       = each.value.desc
  security_group_id = aws_security_group.kafka_sg.id
}

###hazelcast-sg#####
resource "aws_security_group" "hazelcast_sg" {
  name = var.sg_name["hazelcast"]
  description = var.sg_info["hazelcast"]
  vpc_id = var.vpc_id
  egress {
      from_port = "0"
      to_port = "0"
      protocol = "-1"
      cidr_blocks = [ "0.0.0.0/0" ]
  }
  tags = merge( { "Name" = var.sg_name["hazelcast"] }, local.ec2_common_tags )
}

resource "aws_security_group_rule" "sg_hazelcast_ingress_rules" {
  for_each          = var.sg_rules_hazelcast
  type              = "ingress"
  from_port         = each.value.from
  to_port           = each.value.to
  protocol          = each.value.proto
  cidr_blocks       = [each.value.cidr]
  description       = each.value.desc
  security_group_id = aws_security_group.hazelcast_sg.id
}

####grafana-sg
resource "aws_security_group" "grafana_sg" {
  name = var.sg_name["grafana"]
  description = var.sg_info["grafana"]
  vpc_id = var.vpc_id
  egress {
      from_port = "0"
      to_port = "0"
      protocol = "-1"
      cidr_blocks = [ "0.0.0.0/0" ]
  }
  tags = merge( { "Name" = var.sg_name["grafana"] }, local.ec2_common_tags )
}

resource "aws_security_group_rule" "sg_grafana_ingress_rules" {
  for_each          = var.sg_rules_grafana
  type              = "ingress"
  from_port         = each.value.from
  to_port           = each.value.to
  protocol          = each.value.proto
  cidr_blocks       = [each.value.cidr]
  description       = each.value.desc
  security_group_id = aws_security_group.grafana_sg.id
}

####elk-sg
resource "aws_security_group" "elk_sg" {
  name = var.sg_name["elk"]
  description = var.sg_info["elk"]
  vpc_id = var.vpc_id
  egress {
      from_port = "0"
      to_port = "0"
      protocol = "-1"
      cidr_blocks = [ "0.0.0.0/0" ]
  }
  tags = merge( { "Name" = var.sg_name["elk"] }, local.ec2_common_tags )
}

resource "aws_security_group_rule" "sg_elk_ingress_rules" {
  for_each          = var.sg_rules_elk
  type              = "ingress"
  from_port         = each.value.from
  to_port           = each.value.to
  protocol          = each.value.proto
  cidr_blocks       = [each.value.cidr]
  description       = each.value.desc
  security_group_id = aws_security_group.elk_sg.id
}
####kube-sg
resource "aws_security_group" "kube_sg" {
  name = var.sg_name["kube"]
  description = var.sg_info["kube"]
  vpc_id = var.vpc_id
  egress {
      from_port = "0"
      to_port = "0"
      protocol = "-1"
      cidr_blocks = [ "0.0.0.0/0" ]
  }
  tags = merge( { "Name" = var.sg_name["kube"] }, local.ec2_common_tags )
}

resource "aws_security_group_rule" "sg_kube_ingress_rules" {
  for_each          = var.sg_rules_kube
  type              = "ingress"
  from_port         = each.value.from
  to_port           = each.value.to
  protocol          = each.value.proto
  cidr_blocks       = [each.value.cidr]
  description       = each.value.desc
  security_group_id = aws_security_group.kube_sg.id
}

####bastion-sg
resource "aws_security_group" "bastion_sg" {
  name = var.sg_name["bastion"]
  description = var.sg_info["bastion"]
  vpc_id = var.vpc_id
  egress {
      from_port = "0"
      to_port = "0"
      protocol = "-1"
      cidr_blocks = [ "0.0.0.0/0" ]
  }
  tags = merge( { "Name" = var.sg_name["bastion"] }, local.ec2_common_tags )
}

resource "aws_security_group_rule" "sg_bastion_ingress_rules" {
  for_each          = var.sg_rules_bastion
  type              = "ingress"
  from_port         = each.value.from
  to_port           = each.value.to
  protocol          = each.value.proto
  cidr_blocks       = [each.value.cidr]
  description       = each.value.desc
  security_group_id = aws_security_group.bastion_sg.id
}
####ftp-sg###
resource "aws_security_group" "ftp_sg" {
  name = var.sg_name["ftp"]
  description = var.sg_info["ftp"]
  vpc_id = var.vpc_id
  egress {
      from_port = "0"
      to_port = "0"
      protocol = "-1"
      cidr_blocks = [ "0.0.0.0/0" ]
  }
  tags = merge( { "Name" = var.sg_name["ftp"] }, local.ec2_common_tags )
}

resource "aws_security_group_rule" "sg_ftp_ingress_rules" {
  for_each          = var.sg_rules_ftp
  type              = "ingress"
  from_port         = each.value.from
  to_port           = each.value.to
  protocol          = each.value.proto
  cidr_blocks       = [each.value.cidr]
  description       = each.value.desc
  security_group_id = aws_security_group.ftp_sg.id
}


##public-nginx###
resource "aws_security_group" "public_nginx_sg" {
  name = var.sg_name["public-nginx"]
  description = var.sg_info["public-nginx"]
  vpc_id = var.vpc_id
  egress {
      from_port = "0"
      to_port = "0"
      protocol = "-1"
      cidr_blocks = [ "0.0.0.0/0" ]
  }
  tags = merge( { "Name" = var.sg_name["public-nginx"] }, local.ec2_common_tags )
}

resource "aws_security_group_rule" "sg_public-nginx_ingress_rules" {
  for_each          = var.sg_rules_public_nginx
  type              = "ingress"
  from_port         = each.value.from
  to_port           = each.value.to
  protocol          = each.value.proto
  cidr_blocks       = [each.value.cidr]
  description       = each.value.desc
  security_group_id = aws_security_group.public_nginx_sg.id
}
