resource "aws_instance" "opsmanager-server" {
    ami = data.aws_ami.amazon-linux.id
    instance_type = var.instance_type["mongo_ops"]
    key_name = var.key_name
    root_block_device {
      volume_size = var.root_vol_size["mongo_ops"]
      volume_type = var.volume_type["common"]
      tags = {
          "Name" = "${var.instance_tags["mongo_ops"]}-root-vol"
      }
    }
    tags = merge( { "Name" = "${var.instance_tags["mongo_ops"]}" }, local.ec2_common_tags)
    subnet_id = var.priv_sub_id[0] 
    vpc_security_group_ids = [ aws_security_group.mongo_sg.id, aws_security_group.common_sg.id ]
}

resource "aws_ebs_volume" "opsmanager-volume" {
  availability_zone = var.priv_sub_azs[0]
  size = var.data_vol_size["mongo_ops"]
  type = var.volume_type["common"]
  tags = merge( { "Name" = "${var.instance_tags["mongo_ops"]}-data-vol"}, local.ec2_common_tags)
}


resource "aws_volume_attachment" "opsmanager_ebs_att" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.opsmanager-volume.id
  instance_id = aws_instance.opsmanager-server.id 
}

