##kafka-cluster-creation
resource "aws_instance" "kafka-servers" {
    ami = data.aws_ami.amazon-linux.id
    instance_type = var.instance_type["kafka"]
    count = var.instance_count["kafka"]
    key_name = var.key_name
    root_block_device {
      volume_size = var.root_vol_size["kafka"]
      volume_type = var.volume_type["common"]
      tags = { "Name" = "${var.instance_tags["kafka"]}-root-vol-${count.index + 1}" }
    }
    tags = merge( { "Name" = "${var.instance_tags["kafka"]}-${count.index + 1}" }, local.ec2_common_tags)
    subnet_id = var.priv_sub_id[count.index] 
    vpc_security_group_ids = [ aws_security_group.kafka_sg.id, aws_security_group.common_sg.id ]
}

resource "aws_ebs_volume" "kafka-volumes" {
  count = var.instance_count["kafka"]
  availability_zone = var.priv_sub_azs[count.index]
  size = var.data_vol_size["kafka"]
  encrypted = "true"
  type = "gp3"
  tags = merge( { "Name" = "${var.instance_tags["kafka"]}-${count.index + 1}-data-vol"}, local.ec2_common_tags)
}

resource "aws_volume_attachment" "kafka_ebs_att" {
  device_name = "/dev/sdh"
  count= var.instance_count["kafka"]
  volume_id   = aws_ebs_volume.kafka-volumes[count.index].id
  instance_id = aws_instance.kafka-servers[count.index].id 
}

