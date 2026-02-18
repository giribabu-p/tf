
###ELK-Server#########
resource "aws_instance" "elkserver" {
    ami = data.aws_ami.amazon-linux.id
    instance_type = var.instance_type["elk"]
    key_name = var.key_name
    root_block_device {
      volume_size = var.root_vol_size["elk"]
      volume_type = var.volume_type["common"]
      tags = { "Name" = "${var.instance_tags["elk"]}-root-vol" }
    }
    tags = merge( { "Name" = "${var.instance_tags["elk"]}" }, local.ec2_common_tags)
    subnet_id = var.priv_sub_id[0]
    vpc_security_group_ids = [ aws_security_group.elk_sg.id, aws_security_group.common_sg.id ]
}

resource "aws_ebs_volume" "elk-volume" {
  availability_zone = var.priv_sub_azs[0]
  size = var.data_vol_size["elk"]
  type = var.volume_type["common"]
  tags = merge( { "Name" = "${var.instance_tags["elk"]}-data-vol"}, local.ec2_common_tags)
}

resource "aws_volume_attachment" "elk_ebs_att" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.elk-volume.id
  instance_id = aws_instance.elkserver.id 
}


####Prometheus-Grafana-Server############
resource "aws_instance" "grafana-server" {
    ami = data.aws_ami.amazon-linux.id
    instance_type = var.instance_type["grafana"]
    key_name = var.key_name
    root_block_device {
      volume_size = var.root_vol_size["grafana"]
      volume_type = var.volume_type["common"]
      tags = { "Name" = "${var.instance_tags["grafana"]}-root-vol" }
    }
    tags = merge( { "Name" = "${var.instance_tags["grafana"]}" }, local.ec2_common_tags)
    subnet_id = var.priv_sub_id[0] 
    vpc_security_group_ids = [ aws_security_group.grafana_sg.id, aws_security_group.common_sg.id ]
}

resource "aws_ebs_volume" "grafana-volume" {
  availability_zone = var.priv_sub_azs[0]
  size = var.data_vol_size["grafana"]
  type = var.volume_type["common"]
  tags = merge( { "Name" = "${var.instance_tags["grafana"]}"}, local.ec2_common_tags)
}


resource "aws_volume_attachment" "grafana_ebs_att" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.grafana-volume.id
  instance_id = aws_instance.grafana-server.id 
}



