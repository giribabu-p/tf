/*
resource "aws_security_group" "demosg" {
  name = var.ec2_sg_name
  description = var.ec2_sg_info
  vpc_id = var.vpc_id
  dynamic "ingress" {
      for_each = var.web_ports
      content {
          from_port = ingress.value
          to_port = ingress.value
          protocol = "tcp"
          cidr_blocks = [ var.ips["global_ip"], var.ips["my_ip"]]
      }
  }
  egress {
      from_port = "0"
      to_port = "0"
      protocol = "-1"
      cidr_blocks = [ var.ips["global_ip"] ]
  }
  tags = merge( { "Name" = "${var.env}-sg" }, local.ec2_common_tags )
}

data "aws_ami" "amazon-linux" {
  most_recent =  "true"
  owners = [ "amazon" ]
  filter {
    name = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

resource "aws_instance" "kafka-servers" {
    ami = data.aws_ami.amazon-linux.id
    instance_type = var.kafka_instance_type
    count = var.kafka_instance_count
    key_name = var.key_name
    tags = merge( { "Name" = "${var.ec2_kafka_tags}-${count.index + 1}" }, local.ec2_common_tags)
    subnet_id = var.priv_sub_id[count.index] 
    vpc_security_group_ids = [ aws_security_group.demosg.id ]
}

##mongo-cluster-creation
resource "aws_instance" "mongo-servers" {
    ami = data.aws_ami.amazon-linux.id
    instance_type = var.mongo_instance_type
    count = var.mongo_instance_count
    key_name = var.key_name
    tags = merge( { "Name" = "${var.ec2_mongo_tags}-${count.index + 1}" }, local.ec2_common_tags)
    subnet_id = var.priv_sub_id[count.index] 
    vpc_security_group_ids = [ aws_security_group.demosg.id ]
}

resource "aws_ebs_volume" "kafka-volumes" {
  availability_zone = var.priv_sub_azs[count.index]
  count = var.kafka_instance_count
  size = var.kafka_data_vol_size
  encrypted = "true"
  type = "gp3"
  tags = merge( { "Name" = "${var.ec2_kafka_tags}-${count.index + 1}-data-vol"}, local.ec2_common_tags)
}


resource "aws_ebs_volume" "mongo-volumes" {
  count = var.mongo_instance_count
  availability_zone = var.priv_sub_azs[count.index]
  size = var.mongo_data_vol_size
  encrypted = "true"
  type = "gp3"
  tags = merge( { "Name" = "${var.ec2_mongo_tags}-${count.index + 1}-data-vol"}, local.ec2_common_tags)
}


resource "aws_volume_attachment" "mongo_ebs_att" {
  device_name = "/dev/sdh"
  count= var.kafka_instance_count
  volume_id   = aws_ebs_volume.mongo-volumes[count.index].id
  instance_id = aws_instance.mongo-servers[count.index].id 
}

resource "aws_volume_attachment" "kafka_ebs_att" {
  count= var.mongo_instance_count
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.kafka-volumes[count.index].id
  instance_id = aws_instance.kafka-servers[count.index].id 
}

*/
/*
resource "aws_eip" "ec2_eip" {
    vpc = true
    tags = {
    Name = var.ec2_eip_tags
  }
}
resource "aws_eip_association" "eipassc" {
    allocation_id  = aws_eip.ec2_eip.id
    instance_id = aws_instance.kafka-servers[0].id  
}
*/