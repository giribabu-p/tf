##hazelcast-cluster-creation
resource "aws_instance" "hazelcast-servers" {
    ami = data.aws_ami.amazon-linux.id
    instance_type = var.instance_type["hazelcast"]
    count = var.instance_count["hazelcast"]
    key_name = var.key_name
    root_block_device {
      volume_size = var.root_vol_size["hazelcast"]
      volume_type = var.volume_type["common"]
      tags = { "Name" = "${var.instance_tags["hazelcast"]}-root-vol-${count.index + 1}" }
    }
    tags = merge( { "Name" = "${var.instance_tags["hazelcast"]}-${count.index + 1}" }, local.ec2_common_tags)
    subnet_id = var.priv_sub_id[count.index] 
    vpc_security_group_ids = [ aws_security_group.common_sg.id ]
}


