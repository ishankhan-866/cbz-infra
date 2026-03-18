provider "aws" {
  region = "eu-north-1"
}

# VPC
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.1.2"

  name = "eks-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["eu-north-1", "eu-north-1"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets  = ["10.0.3.0/24", "10.0.4.0/24"]

  enable_nat_gateway = true
  single_nat_gateway = true

  tags = {
    "kubernetes.io/cluster/eks-cluster" = "shared"
  }
}

# EKS Cluster
module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.8.4"

  cluster_name    = "eks-cluster"
  cluster_version = "1.29"

  subnet_ids = module.vpc.private_subnets
  vpc_id     = module.vpc.vpc_id

  enable_irsa = true

  # Node group (2 nodes)
  eks_managed_node_groups = {
    default = {
      desired_size = 2
      max_size     = 2
      min_size     = 2

      instance_types = ["t3.micro"]

      capacity_type = "ON_DEMAND"
    }
  }

  tags = {
    Environment = "dev"
  }
}
