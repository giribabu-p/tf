
###ftp-Server#########
resource "aws_instance" "ftpserver" {
    ami = data.aws_ami.amazon-linux.id
    instance_type = var.instance_type["ftp"]
    key_name = var.key_name
    root_block_device {
      volume_size = var.root_vol_size["ftp"]
      volume_type = var.volume_type["common"]
      tags = { "Name" = "${var.instance_tags["ftp"]}-root-vol" }
    }
    tags = merge( { "Name" = "${var.instance_tags["ftp"]}" }, local.ec2_common_tags)
    subnet_id = var.priv_sub_id[0]
    vpc_security_group_ids = [ aws_security_group.ftp_sg.id, aws_security_group.common_sg.id ]
}

##ssh-internal-sg#######
resource "aws_instance" "kube-server" {
    ami = data.aws_ami.amazon-linux.id
    instance_type = var.instance_type["kube"]
    key_name = var.key_name
    root_block_device {
      volume_size = var.root_vol_size["kube"]
      volume_type = var.volume_type["common"]
      tags = { "Name" = "${var.instance_tags["kube"]}-root-vol" }
    }
    tags = merge( { "Name" = "${var.instance_tags["kube"]}" }, local.ec2_common_tags)
    subnet_id = var.priv_sub_id[0] 
    vpc_security_group_ids = [ aws_security_group.kube_sg.id, aws_security_group.common_sg.id ]
}



