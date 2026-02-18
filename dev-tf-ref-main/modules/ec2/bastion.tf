
####bastion-Server############
resource "aws_instance" "bastion-server" {
    ami = data.aws_ami.amazon-linux.id
    instance_type = var.instance_type["bastion"]
    key_name = var.key_name
    root_block_device {
      volume_size = var.root_vol_size["bastion"]
      volume_type = var.volume_type["common"]
      tags = {
          "Name" = "${var.instance_tags["bastion"]}-root-vol"
      }
    }
    tags = merge( { "Name" = "${var.instance_tags["bastion"]}" }, local.ec2_common_tags)
    subnet_id = var.priv_sub_id[1] 
    vpc_security_group_ids = [ aws_security_group.bastion_sg.id, aws_security_group.common_sg.id ]
}

