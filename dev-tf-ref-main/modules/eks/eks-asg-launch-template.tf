/*
resource "aws_launch_template" "worker-lt" {
  name = "eks-custom-launch-template"
  instance_type           = "t3.micro" #var.eks_instance_type
  #key_name                = data.terraform_remote_state.iam.outputs.key_name
  tags                    = {}
  block_device_mappings {
    device_name = "/dev/sda1"
    ebs {
      volume_size = 20
    }
  }
 
  image_id                = data.aws_ssm_parameter.eksami.value
  user_data            = base64encode(local.eks-node-private-userdata)
  vpc_security_group_ids = [ aws_eks_cluster.eks_cluster.vpc_config[0].cluster_security_group_id ]
  tag_specifications { 
        resource_type = "instance"
    tags = {
        Name = "stage-eks-worker-nodes"
        Environment = "stage"
        }
    }
  lifecycle {
    create_before_destroy=true
  }
}


data "aws_ssm_parameter" "eksami" {
  name=format("/aws/service/eks/optimized-ami/%s/amazon-linux-2/recommended/image_id", data.aws_eks_cluster.eks_cluster.version)
}              

locals {
  eks-node-private-userdata = <<USERDATA
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="==MYBOUNDARY=="

--==MYBOUNDARY==
Content-Type: text/x-shellscript; charset="us-ascii"

#!/bin/bash -xe
sudo /etc/eks/bootstrap.sh --apiserver-endpoint '${data.aws_eks_cluster.eks_cluster.endpoint}' --b64-cluster-ca '${data.aws_eks_cluster.eks_cluster.certificate_authority[0].data}' '${data.aws_eks_cluster.eks_cluster.name}'
echo "Running custom user data script" > /tmp/me.txt
yum install -y amazon-ssm-agent
echo "yum'd agent" >> /tmp/me.txt
yum update -y
systemctl enable amazon-ssm-agent && systemctl start amazon-ssm-agent
date >> /tmp/me.txt

--==MYBOUNDARY==--
USERDATA
}

data "aws_eks_cluster" "eks_cluster" {
   name = aws_eks_cluster.eks_cluster.name
  #name = data.terraform_remote_state.cluster.outputs.cluster-name
}

/*
resource "aws_eks_addon" "kube-proxy" {
  depends_on     = [aws_eks_node_group.ng1]
  cluster_name = data.aws_eks_cluster.eks_cluster.name
  addon_name   = "kube-proxy"
}

resource "aws_eks_addon" "coredns" {
  depends_on     = [aws_eks_node_group.ng1]
  cluster_name = data.aws_eks_cluster.eks_cluster.name
  addon_name   = "coredns"
}

  #block_device_mappings {
  #  device_name = "/dev/sda1"

  #  ebs {
  #    volume_size = 20
  #  }
  #}
 
  
## Enable this when you use cluster autoscaler within cluster.
## https://github.com/kubernetes/autoscaler/blob/master/cluster-autoscaler/cloudprovider/aws/README.md

#  tag {
#    key                 = "k8s.io/cluster-autoscaler/enabled"
#    value               = ""
#    propagate_at_launch = true
#  }
#
#  tag {
#    key                 = "k8s.io/cluster-autoscaler/${var.cluster-name}"
#    value               = ""
#    propagate_at_launch = true
#  }



*/