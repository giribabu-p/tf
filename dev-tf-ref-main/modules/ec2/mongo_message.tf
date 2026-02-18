/*
resource "aws_security_group" "mongosg" {
  name = var.mongo_sg_name
  description = var.mongo_sg_info
  vpc_id = var.vpc_id
  dynamic "ingress" {
      for_each = var.mongo_ports
      content {
          from_port = ingress.value
          to_port = ingress.value
          protocol = "tcp"
          cidr_blocks = [ var.mongo_ips["global_ip"], var.mongo_ips["my_ip"]]
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
*/

##mongo-cluster-creation
resource "aws_instance" "mongo-servers" {
    ami = data.aws_ami.amazon-linux.id
    instance_type = var.instance_type["mongo_message"]
    count = var.instance_count["mongo_message"]
    key_name = var.key_name
    root_block_device {
      volume_size = var.root_vol_size["mongo_message"]
      volume_type = var.volume_type["common"]
      tags = { "Name" = "${var.instance_tags["mongo_message"]}-root-vol-${count.index + 1}" }
    }
    tags = merge( { "Name" = "${var.instance_tags["mongo_message"]}-${count.index + 1}" }, local.ec2_common_tags)
    subnet_id = var.priv_sub_id[count.index] 
    vpc_security_group_ids = [ aws_security_group.common_sg.id, aws_security_group.mongo_sg.id ]
}

resource "aws_ebs_volume" "mongo-volumes" {
  count = var.instance_count["mongo_message"]
  availability_zone = var.priv_sub_azs[count.index]
  size = var.data_vol_size["mongo_message"]
  encrypted = "true"
  type = var.volume_type["common"]
  tags = merge( { "Name" = "${var.instance_tags["mongo_message"]}-${count.index + 1}-data-vol"}, local.ec2_common_tags)
}

resource "aws_volume_attachment" "mongo_ebs_att" {
  device_name = "/dev/sdh"
  count= var.instance_count["mongo_message"]
  volume_id   = aws_ebs_volume.mongo-volumes[count.index].id
  instance_id = aws_instance.mongo-servers[count.index].id 
}

