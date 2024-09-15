provider "aws" {
  region = var.aws_region
}

data "aws_availability_zones" "available" {}
# Retrieves a list of all available Availability Zones in the specified region.

locals {
  cluster_name = "aayu-eks"
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  version = "5.13.0"

  name = "my-vpc"
  cidr = var.vpc_cidr

  azs                  = data.aws_availability_zones.available.names
  private_subnets      = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets       = ["10.0.4.0/24", "10.0.5.0/24"]

  enable_nat_gateway = true
  single_nat_gateway = true

  # Enables DNS hostnames for instances within the VPC.
  enable_dns_hostnames = true

  # Enables DNS support for the VPC, allowing domain name resolution.
  enable_dns_support = true


  # Marks VPC resources as shared to be used by k8s cluster
  tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
  }

  # for external loadbalancing
  public_subnet_tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
    "kubernetes.io/role/elb"                      = "1"
  }

  # for internal loadbalancing
  private_subnet_tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
    "kubernetes.io/role/internal-elb"             = "1"
  }
}