
###VPN-Server#########
resource "aws_instance" "public-nginx-server" {
    ami = data.aws_ami.amazon-linux.id
    instance_type = var.instance_type["public-nginx"]
    key_name = var.key_name
    root_block_device {
      volume_size = var.root_vol_size["public-nginx"]
      volume_type = var.volume_type["common"]
      tags = {
          "Name" = "${var.instance_tags["public-nginx"]}-root-vol"
      }
    }   
    tags = merge( { "Name" = "${var.instance_tags["public-nginx"]}" }, local.ec2_common_tags)
    subnet_id = var.pub_sub_id[0]
    vpc_security_group_ids = [ aws_security_group.public_nginx_sg.id, aws_security_group.common_sg.id ]
}
