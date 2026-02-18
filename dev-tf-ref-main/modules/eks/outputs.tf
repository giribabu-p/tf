
output "kubeconfig-certificate-authority-data" {
  value = aws_eks_cluster.eks_cluster.certificate_authority
}

output "cluster-arn" {
  value = aws_eks_cluster.eks_cluster.arn
}
output "cluster-endpoint"{
    value = aws_eks_cluster.eks_cluster.endpoint
}
output "cluster-status" {
  value =  aws_eks_cluster.eks_cluster.status
}

