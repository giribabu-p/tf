resource "aws_iam_role" "cluster_role" {
  name = "eks_cluster_role"


  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "eks-cluster-AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.cluster_role.name
}

resource "aws_iam_role_policy_attachment" "eks-cluster-AmazonEKSServicePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
  role       = aws_iam_role.cluster_role.name
}

resource "aws_eks_cluster" "eks_cluster" {
  name     = var.cluster_name
  version = "1.21"
  role_arn = aws_iam_role.cluster_role.arn
  
  vpc_config {
    endpoint_private_access = "true"
    endpoint_public_access = "false"
    subnet_ids = ["subnet-0f3b0d01a275f0250","subnet-0895d7b63609120af","subnet-0eb6c72eaa3bce2dc","subnet-01844355bd3b8abbf" ]
    #subnet_ids = [ var.pub_sub_names[0], var.pub_sub_names[1], var.priv_sub_names[0], var.priv_sub_names[1] ]
    security_group_ids = [ aws_security_group.eks_cluster_additional_sg.id ]
  }
  tags = {
    "Environment" = "stage"
  }
  depends_on = [
    aws_iam_role_policy_attachment.eks-cluster-AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.eks-cluster-AmazonEKSServicePolicy
  ]
}

resource "aws_security_group" "eks_cluster_additional_sg" {
  name = var.sg_name["eks_cluster_additional_sg"]
  description = var.sg_info["eks_cluster_additional_sg"]
  vpc_id = "vpc-08fcbad31b564128e"
  egress {
      from_port = "0"
      to_port = "0"
      protocol = "-1"
      cidr_blocks = [ "0.0.0.0/0" ]
  }
  tags = merge( { "Name" = var.sg_name["eks_cluster_additional_sg"] } )
}

resource "aws_security_group_rule" "sg_eks_cluster_additional_ingress_rules" {
  for_each          = var.sg_rules_eks_additional
  type              = "ingress"
  from_port         = each.value.from
  to_port           = each.value.to
  protocol          = each.value.proto
  cidr_blocks       = [each.value.cidr]
  description       = each.value.desc
  security_group_id = aws_security_group.eks_cluster_additional_sg.id
}